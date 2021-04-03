{-
 - Specified Implementation Details:
 - 
 - Write a program that keeps track of information about Persons.
 - A Person has a character string attribute called name and an
 - integer attribute called age.  If your language permits,
 - you should create an abstract data type for this kind of information.
 - If your language does not have a mechanism for building abstract
 - datatypes such as a record, struct, class, etc., improvise.
 -
 - Your program should read from this data file of comma-delimited
 - name/age pairs and populate your program with a collection (or array)
 - of Persons.  Your program should then sort the set by name,
 - output the name of each Person in sorted order,
 - and output the average age of all the Persons.
 -
 - Note: if you find working with my datafile to be too difficult
 - you may either modify the structure (but not the order) of the
 - datafile or hard-code the data into your program (while preserving
 - the initial order of the data) but you must jusitify your inability
 - to perform I/O on the existing datafile in your report.
 -
 - ---
 -
 - Implementation Details:
 -}
val fileName = "Person.dat"
import class File = "java.io.File"
import class FileReader = "java.io.FileReader"
import class BufferedReader = "java.io.BufferedReader"
val file = File(fileName)
val reader = BufferedReader(FileReader(file))

{-
 - a Person site which holds a name and age.
 - I can use the `suppliedAge :: Number` here to
 - give a type hint for the parameter,
 - so when I pass in a string of age, it will automatically convert
 - it to the proper data type
 -}
def class Person(suppliedName, suppliedAge :: Number) =
    val name = suppliedName
    val age = suppliedAge

    def getName() = name
    def getAge() = age

    stop

-- Reads the next line in the reader and conferts it into a Person site 
def getPerson() =
    val line = arrayToList(reader.readLine().split(","))
    Person(index(line, 0), index(line, 1)) 

-- recursively fills the provided list with Person sites
def initializePersonList(index, list) =
    if (index <: 7) then initializePersonList(index+1, getPerson():list)
    else list 


val personList = initializePersonList(0,[])
index(personList, 0).getAge()
