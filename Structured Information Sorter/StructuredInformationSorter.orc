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

 {-
  - This sets up the .dat file and various imports needed to
  - read the Person.dat file
  -}
val fileName = "Person.dat"
import class File = "java.io.File"
import class FileReader = "java.io.FileReader"
import class BufferedReader = "java.io.BufferedReader"
val file = File(fileName)
val reader = BufferedReader(FileReader(file))

{-
 - a Person site which holds a name and age.
 - I can use the `age :: Number` here to
 - give a type hint for the parameter,
 - so when I pass in a string of age, it will automatically convert
 - it to the proper data type
 -
 - on a side note, it is sometimes a little janky with type hints
 - so I specified `Read(age)` to make sure the age is converted to a number
 -}
def class Person(name, age:: Number) =
    def getName() = name
    def getAge() = Read(age)
    stop

-- Reads the next line in the reader and converts it into a Person site 
def getPerson() =
    val line = arrayToList(reader.readLine().split(","))
    Person(index(line, 0), index(line, 1)) 

-- recursively fills the provided array with Person sites
def initializePersonArray(index, array) =
    if (index <: 7) then array(index) := getPerson() >> initializePersonArray(index+1, array)
    else array 

-- grabs the indexed value of the array, and gets the average.
-- I recognize that this could be done with a lambda but I'm having some issues
-- figuring that out
def ageAverage(index, array, average) =
    if (index <: 7) then ageAverage(index+1, array, average+array(index)?.getAge())
    else average / index

--val personList = initializePersonList(0,[])
--upto(7) >i> personArray(i)?.getAge()


val personArray = initializePersonArray(0, Array(7))
val nameArray = Array(7)

-- @TODO use a map function
for(0, nameArray.length?) >i>
nameArray(i) := personArray(i)?.getName() >>
stop
; sort(arrayToList(nameArray)) | "Average age: " + ageAverage(0, personArray, 0)
