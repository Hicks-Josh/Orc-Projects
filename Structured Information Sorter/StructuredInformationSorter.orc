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

def Person(name, age) =
    def getName() = name
    def getAge() = age

import class File = "java.io.File"
import class FileReader = "java.io.FileReader"
import class BufferedReader = "java.io.BufferedReader"
val f = File("Person.dat")
val reader = BufferedReader(FileReader(f))

{-
 - Originally I wanted to use an array for the data structure but aside from it
  - being immutable, it also can only hold primitive types,
  - therfore in order to hold a `Person` data type I'll need to go with
   - something like a list.
 -}

val l = []
def initList(i) =
    if (i <: 7) then
        val str = reader.readLine()
        l(i) := i >> initList(i+1)
        else signal
        
initList(0) >> l(0)? >> l(1)?
{-
val a = Array(7)
def init(i) =
     if (i <: 7) then
        val str = reader.readLine()
        a(i) := new Person(str.split(",")(0), str.split(",")(1)) >> init(i+1)
        else signal

init(0) >>
a(0).read() >Person(n1,_)>
a(1)?.get >Person(n2,_)>
(n1 | n2)
-}




