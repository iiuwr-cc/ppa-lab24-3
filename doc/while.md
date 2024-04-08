While language
==============

The WHILE language is simple imperative language containing basic
arithmetic and control operators. The language has two variants.  One
variant is named *structural* and is almost identical to the language
presented in the course book. The second variant, named *labeled*, is
a simplified version where all control operators are replaced by
`goto` statement and each instruction is labeled. This variant is used
internally for static analyses. The motivation behind the split is to
make automatic testing possible.


See [directory with examples](../examples/) to see basic
programs. Formal specification of the syntax can be found in [grammar
file](../source/while/parser.mly) and [lexer
file](../source/while/lexer.mll).


Printing Program in the Labeled Variant
---------------------------------------

```
$ ./install/apk while simplify source.while [-o output_file]
```

If the `-o/--output` switch is missing then program is printed to standard output.

Printing Control-Flow-Graph in the Graphviz Format
--------------------------------------------------

```
$ ./install/apk while cfg source.while [-o output_file]
```

If the `-o/--output` switch is missing then program is printed to standard output.

For your own convenience you can compose this command with xdot tool.

```
$ ./install/apk while cfg source.while -o /dev/stdout | xdot -
```

Executing Static Analyses
-------------------------

```
$ ./install/apk while analyse analyse_name source.while [-t table_output] [-c cfg_output] [-a algorithm] [-s]
```

Options

* `-t/--table` - dumps the result of the analysis to a text file. Used by the testing script.
* `-c/--cfg` - dumps the control flow graph annotated with the analysis result. 
* `-s/--stats` - prints statistics
* `-a/--algorithm` - sets dataflow algorithm. The default is `chaotic-iteration`

Example:

```
$ ./install/apk while analyse reaching_definitions examples/rd.while -c /dev/stdout | xdot -
```

Programming Static Analyses
---------------------------

See [MonotoneFramework interfaces](../source/while/analysis.ml) and [example analyses](../source/solutions/examples.ml).
You can write your analyses in the [student.ml file](../source/solutions/student.ml).

Recording Tests
--------------

You can create tests using [record.sh](../scripts/record.sh) script. 

Example

```
$ ./scripts/record.sh examples/rd.while while reaching_definitions
```

It will print test file that can be stored inside `tests` directory. The file contains the source code in labeled form and the expected analysis result. 
