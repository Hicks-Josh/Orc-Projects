import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.regex.Pattern;
import java.util.regex.Matcher;


/**
 * Class to represent a "grammar" from a file of the form:
 * <pre>
 *    {
 *    &lt;left-hand-side&gt;
 *    production body ;
 *    production body ;
 *    ...
 *    }
 * </pre>
 * where the first symbol names the set of production bodies and
 * production bodies are separated by ';' (they may span lines)
 *
 * @author David M. Hansen
 * @version 3.0
 *
 * Modified by DM Hansen 2/18/15
 *    2.0 fixed "bug" that each production needed to be on one line
 *    and eliminated unnecessary use of regex, simplifying the FSA
 * Modified by DM Hansen 12/25/17
 *    3.0 made the Symbol class a public inner-class vs. external class
 */
public class Grammar {

    // The start symbol for the grammar
    private Symbol _startSymbol;

    // The productions of the grammar where each Symbol is mapped to
    // a list of Symbols that define a production
    private HashMap<Symbol, ArrayList <ArrayList<Symbol>>> _symbolTable;


    /**
     * Build a grammar from the given input
     *
     * @param input is scanner from which to read the grammar
     *
     * @throws IOException if input stream is bad
     * */
    public Grammar(Scanner input) throws IOException {
        // Lexemes used to identify productions
        final String START_TOKEN = "{";
        final String END_TOKEN = "}";
        final String BODY_END = ";";

        // The symbol table we'll populate
        _symbolTable =
                new HashMap<Symbol, ArrayList<ArrayList<Symbol>>>();

        // List of symbols we encounter in a given production
        ArrayList<Symbol> symbolList = new ArrayList<>();

        // The algorithm uses a simple finite-state-machine to parse the
        // input. These flags are used to tell what state we're in
        // while processing a particular grammar production.
        boolean readingAProduction = false;
        boolean readingBodies = false;

        // Used during parsing to represent parts of productions
        Symbol leftHandSideSymbol = null;
        String currentSymbol = null;


        // Read the words of the file looking for productions.
        // When we see one, start parsing the production
        // and add the production to the symbol table.
        while (input.hasNext()) {
            currentSymbol = input.next();
            // If we're not yet reading a production, check to see if the
            // current symbol is the production start token
            if (!readingAProduction) {
                readingAProduction = currentSymbol.equals(START_TOKEN);
            }
            // Otherwise see if the symbol is the production stop token.
            // If so, set the flag to indicate that we've hit the end of
            // a production, otherwise we've got the head or body of a
            // production
            else if (currentSymbol.equals(END_TOKEN)) {
                readingAProduction = false;
                readingBodies = false;
            }
            // Otherwise we must be reading a production
            // so this is the head or bodies of a production
            else {
                // If we're not reading a body then this must be a new
                // production and we're looking at the left-hand-side so
                // start a new entry in the symbol table
                if (!readingBodies) {
                    // Add this new left hand side to the symbol table
                    // with an empty list of symbol lists
                    leftHandSideSymbol = new Symbol(currentSymbol);
                    _symbolTable.put(leftHandSideSymbol, new ArrayList<ArrayList<Symbol>>());
                    // Should now be reading production bodies
                    readingBodies = true;

                    // If this is the first left-hand-side we've seen
                    // then it's also the start symbol for the grammar
                    if (_startSymbol == null) {
                        _startSymbol = leftHandSideSymbol;
                    }
                }
                // Otherwise we're in the body of a production
                else {
                    // If the symbol is the end symbol, then we're done
                    // reading a particular production body
                    if (currentSymbol.equals(BODY_END)) {
                        // END so we're done reading this body. Add
                        // the list of symbols (not including this
                        // end symbol) to the symbol table for the
                        // current left-hand-side
                        _symbolTable.get(leftHandSideSymbol).add(symbolList);

                        // Allocate a new list of symbols for the
                        // next production body we encounter
                        symbolList = new ArrayList<Symbol>();
                    }
                    // Otherwise not at the end, add this symbol to current list
                    else {
                        // If the symbol is the literal string "\n" we'll turn that
                        // into an actual newline, otherwise just add the
                        // symbol to the list
                        if (currentSymbol.equals("\\n")) {
                            symbolList.add(new Symbol("\n"));
                        }
                        else {
                            symbolList.add(new Symbol(currentSymbol));
                        }
                    }
                } // else

            } // else if

        } // while

    } // GrammarParser


    /**
     * Return the symbols and productions of the grammar
     *
     * @return the table of symbols and productions
     */
    public HashMap<Symbol, ArrayList<ArrayList<Symbol>>> getSymbolTable() {
        return _symbolTable;
    }


    /**
     * Return the start symbol for the grammar
     *
     * @return the start symbol for this grammar
     */
    public Symbol getStartSymbol() {
        return _startSymbol;
    }




    /**
     * Simple class representing terminal and non-terminal
     * grammar symbols
     *
     * @author David M. Hansen
     * @version 1.1
     */
    public static class Symbol {

        // REGEX pattern for matching non-terminal symbols that begin
        // with <, end with >
        private final static Pattern NON_TERM = Pattern.compile("^<.*>$");

        // The value of this symbol
        private String _value;


        /**
         * Create a new symbol with the given value
         *
         * @param value is the string value of the symbol
         */
        public Symbol(String value) {
            _value = value;
        }


        /**
         * Return true if this is a non-terminal symbol
         *
         * @return true if this is a non-terminal symbol
         */
        public boolean isNonTerminal() {
            // See if the pattern matches the NON_TERM pattern
            return NON_TERM.matcher(_value).find();
        }


        /**
         * Return true if this is a terminal symbol
         *
         * @return true if this is a terminal symbol
         */
        public boolean isTerminal() {
            // If not a non-terminal, then a terminal
            return !isNonTerminal();
        }


        /**
         * Return the symbol value
         *
         * @return symbol value
         */
        @Override
        public String toString() {
            return _value;
        }


        /**
         * Return true if symbol's strings are equal
         *
         * @return true if the symbol's strings are equal
         */
        @Override
        public boolean equals(Object o) {
            // Nothing is equal to null; otherwise test
            return o == null ? false :
                    o instanceof Symbol // Class must be same
                            && _value.equals(((Symbol) o)._value);
        }


        /**
         * Return value's hashCode
         *
         * @return hashCode from our string value
         */
        @Override
        public int hashCode() {
            return _value.hashCode();
        }

    } // Symbol




    /**
     * Simple test program to read a file and dump the start symbol and
     * symbol table found in that file
     *
     * @param args is filename containing grammar
     *
     * @throws IOException if input file is bad
     */
    public static void main(String[] args) throws IOException {
        Grammar aGrammar = null;

        // Open the given grammar file
        if (args.length == 0) {
            System.err.println("Usage: java Grammar <filename>");
            System.exit(1);
        }

        try {
            aGrammar = new Grammar(new Scanner(new File(args[0])));
        }
        catch (IOException e) {
            System.err.println("Error accessing file " + args[0]);
            System.exit(1);
        }

        System.out.println("Start is :" + aGrammar.getStartSymbol());
        System.out.println("Productions are :" +
                aGrammar.getSymbolTable().get(aGrammar.getStartSymbol()));
        System.out.println("Symbol table is :\n" + aGrammar.getSymbolTable());

    } // main

} // Grammar
