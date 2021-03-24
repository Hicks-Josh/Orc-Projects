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

type Person = Person(_,_) | Empty()

import class File = "java.io.File"
import class FileReader = "java.io.FileReader"
import class BufferedReader = "java.io.BufferedReader"
val f = File("Person.dat")
val reader = BufferedReader(FileReader(f))


{- @TODO
 - I need to find a way to split the buffered reader by the ','
 - then put the first into the name and the second to be
 - casted into a number, and put these two values into a Person type
 -}
val a = Array(7)
def init(i) =
     if (i <: 7) then
        val str = reader.readLine()
        val name = str.split(",")(0)
        val age = str.split(",")(1)
        a(i) := Person(name, age) >> init(i+1)
    else signal

init(0) >> a(0)? >Person(n1,_)> n1

{-
a(0)?.get() >Person(n1,_)>
a(1)?.get() >Person(n2,_)>
-- | a(2) | a(3) | a(4) | a(5) | a(6))
(n1 | n2)
-}




