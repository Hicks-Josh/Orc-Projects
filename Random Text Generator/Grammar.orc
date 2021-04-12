{-
 - Re-implement the Random Text Generator program that
 - is assigned in approximately the 4th week of the course
 - using your programming language.
 -
 - My approach:
 - The { means the next line will contain the key symbol
 - then the lines after, seperated by a ; will be the sentences in a list
 - which is ended by a } 
 -}

val START_TOKEN = "{"
val END_TOKEN = "}"
val BODY_END = ";"

-- sets up the buffered reader 
val fileName = "pilot-episode.g"
import class File = "java.io.File"
import class FileReader = "java.io.FileReader"
import class BufferedReader = "java.io.BufferedReader"
val file = File(fileName)
val reader = BufferedReader(FileReader(file))

val startSymbol = Ref(null)

-- it's a dictionary with k: symbol v: list<symbol>
val symbolTable = Dictionary()
val symbolList = Ref([])

val leftHandSideSymbol = Ref(null)
val currentSymbol = Ref(null)
val readingAProduction = Ref(false)
val readingBodies = Ref(false)

def class Symbol(token :: String) =
    
    def getSymbol() = token
    def is(otherToken) = if (token?.equals(otherToken)) then true else false

    stop


def checkIfBody()  =
    val notAToken = Ref(true)
    -- If we're not yet reading a production check to see if the current
    -- symbol is the production start token
    if (readingAProduction? = false) then
        readingAProduction := currentSymbol.is(START_TOKEN) >>
        notAToken := false
    -- Otherwise see if the symbol is the production stop token
    -- If so, set the flag to indicate that we've hit the end of a production,
    -- Otherwise we've got the head or body of a production
    else (Ift (currentSymbol?.is(END_TOKEN)) >>
        readingAProduction := false >>
        readingBodies := false >>
        notAToken := false) 
    ;notAToken?


def checkIfProduction() =
    val isProduction = Ref(false)
    -- there is the Iff operator that I could use instead of 
    -- readingBodies = false
    -- but this was sleeker to use
    (Ift (readingBodies? = false) >> 
        isProduction := true >>
        leftHandSideSymbol := Symbol(currentSymbol) >>
        symbolTable.leftHandSideSymbol := [] >>
        readingBodies := true >>
        -- if this is the first left hand side we've seen
        -- then it's also the start symbol for the grammar
        Ift (startSymbol = null) >> startSymbol := leftHandSideSymbol)
    isProduction?


-- Otherwise we're in the body of the production
def productionBody() =
    -- If the symbol is the end symbol, then we;re done reading a
    -- particular production body
    if (currentSymbol.is(BODY_END)) then
        symbolTable.leftHandSideSymbol := symbolTable.leftHandSideSymbol?:symbolList >>
        symbolList := []
    -- Otherwise not at the end, add this symbol for the next production
    -- body we encounter
    else
        -- If the symbol is the literal string "\n" we'll turn that
        -- into an actual newline, otherwise just add the symbol to the list
        if (currentSymbol.is("\n")) then symbolList := symbolList:Symbol("\n")
        else symbolList := symbolList:Symbol(currentSymbol)


def loopThroughFile(readingAProduction) =
    currentSymbol := reader.readLine() >>

    Ift (currentSymbol = null) >> signal
    -- Otherwise we must be reading a production
    -- so this is the bead or bodies of a production
    Iff (checkIfBody()) >> Iff(checkIfProduction()) >> productionBody()
    ;
        

-- loopThroughFile(readingAProduction-false
loopThroughFile(false)
