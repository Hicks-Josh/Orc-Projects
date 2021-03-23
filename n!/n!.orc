{-
 - Prompt takes in the value
 - by surrounding the >> operator with the function call,
 - I can pass in whatever is read from the Prompt.
 -
 - Read(number) will convert whatever is inside to whatever
 - value it can infer, in this case it should be an int.
 -}

{-
 - To be more specific I could define the parameters
 - and return return types in this manner
 -
 - def factorial(Number) :: Number
-}
def factorial(n) = if (n <= 1) then 1 else n * factorial(n - 1)

Prompt("What do you want to find the factorial of? ")
>number>
factorial(Read(number))
