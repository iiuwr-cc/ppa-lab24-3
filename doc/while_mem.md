While_mem language
==================

The WHILE_MEM language is a simple extension of the [WHILE](while.md)
language with pointers. Similarly to the WHILE language it has two
variants, *structural* and *labeled*.

See [directory with examples](../examples/mem) to see example
programs. The formal specification of the syntax can be found in
[grammar](../source/while_mem/parser.mly) and
[lexer](../source/while_mem/lexer.mll) files.

Basic usage of the system is similar to the WHILE variant. The main
difference is built-in Andersen algorithm for points-to analysis (see
below).


Andersen Analysis
-----------------

Andersen analysis is a simple flow-insensitive points_to analysis. To
execute the analysis run

```
$ ./install/apk while_mem andersen  source.whilemem
```
Example

```
$ ./install/apk while_mem andersen examples/mem/cp.whilemem
```

Printing Program in the Labeled Variant
---------------------------------------

```
$ ./install/apk while_mem simplify source.whilemem [-o output_file]
```

If the `-o/--output` switch is missing then program is printed to standard output.

Printing Control-Flow-Graph in the Graphviz Format
--------------------------------------------------

```
$ ./install/apk while_mem cfg source.whilemem [-o output_file]
```

If the `-o/--output` switch is missing then program is printed to standard output.

For your own convenience you can compose this command with xdot tool.

```
$ ./install/apk while_mem cfg source.whilemem -o /dev/stdout | xdot -
```

Executing Static Analyses
---------------------------

```
$ ./install/apk while_mem analyse analysis_name source.whilemem [-t table_output] [-c cfg_output] [-a algorithm] [-s]
```

Options

* `-t/--table` - dumps result of analysis to text file. Used by the testing script.
* `-c/--cfg` - dumps control flow graph annotated with analysis result. 
* `-s/--stats` - print statistics
* `-a/--algorithm` - sets dataflow algorithm. The default is `chaotic-iteration`


Programming Static Analyses
----------------------------

See [MonotoneFramework interfaces](../source/while_mem/analysis.ml).
You can
write your analyses in the [student.ml](../source/solutions/student.ml) file. A flow-sensitive points-to
analysis is expected in the
[student_pto.ml](../source/solutions/student_pto.ml) file.

Recording Tests
--------------

You can create tests using [record.sh](../scripts/record.sh) script. 

Example

```
$ ./scripts/record.sh examples/mem/cp.whilemem while_mem cp_mem_andersen
```

It will print test file that can be stored inside `tests`
directory. The file contains the source code in labeled form and the
expected analysis result.
