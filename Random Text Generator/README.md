# TODO

## Initial values
```
START_TOKEN = "{"
END_TOKEN = "}"
BODY_END = ";"

symbolTable = Dictionary()      -- hashmap<Symbol, ArrayList<ArrayList<Symbol>>>()

symbolList = []                 -- ArrayList<Symbol>

readingAProduction = false
readingBodies = false

leftHandSideSymbol = null
currentSymbol = null
```

## While there is a line left
```
currentSymbol = reader.readLine()

Iff (readingAProduction) >> readingAProduction = currentSymbol.equals(START_TOKEN)
```

