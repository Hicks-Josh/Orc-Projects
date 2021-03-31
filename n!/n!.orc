{-
 - Specified Implementation Details:
 -
 - Write a factorial program (perferably recursive) that accepts
 - a single integer n as input and outputs n!.
 - Input can be passed to the program as a command-line parameter
 - (preferred) or read from the keyboard.
 -
 - Note: if your language provides some sort of factorial function
 - or operation, write your own here to demonstrate how to write
 - (recursive) functions.
 -
 - ---
 -
 - Implementation Details:
 -
 - Prompt takes in the value
 - by surrounding the >> operator with the assignment to 'Number,'
 - I can pass in whatever is read from the Prompt via that value.
 -
 - Read(number) will convert whatever is inside to whatever
 - value it can infer, in this case it should be an int.
 -
 - To be more specific I could define the parameters
 - and return types in this manner
 -
 - def factorial(Number) :: Number
-}
def factorial(n) = if (n <= 1) then 1 else n * factorial(n - 1)

Prompt("What do you want to find the factorial of? ")
>number>
factorial(Read(number))
