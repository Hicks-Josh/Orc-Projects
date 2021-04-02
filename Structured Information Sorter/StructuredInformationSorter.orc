{-
 - Specified Implementation Details:
 - 
 - Write a program that keeps track of information about Persons.
 - A Person has a character string attribute called name and an
 - integer integer attribute called age.  If your language permits,
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

{- Creates a Person data type -} 
type Person = Person(_,_)

def initializePersonList(index, list) =
    if (index <: 7) then
        val str = reader.readLine()
        str:list >> initializePersonList(index+1, list)
    else signal


{-
 - by using the >> operator,
 - it makes everything happen in sequence
 - my issue was that I was concatenating the list,
 - then calling the function again,
 - the issue was that I wasn't assigning list to the new list,
 - so it was just passing an empty list with every call
 -}
def initializeList(index, list) =
    if (index <: 7) then initializeList(index +1, reader.readLine():list)
    else list 

val personList = initializeList(0, [])
personList

