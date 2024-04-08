Principles of Program Analysis -- Labolatory
============================================


-----

**Please do not publish your solutions.**

-----


* [WHILE language documentation](doc/while.md)
* [WHILE_MEM language documentation](doc/while_mem.md)


Build requirements
------------------

The tool requires ocaml 5.1.1 with additional packages:

* library `ocamlgraph` - tested with version 2.1.0
* library `cmdliner` - tested with version 1.2.0
* parser generator `menhir` - tested with version 20231231
* build system `dune` - tested with version 3.14.2

If you have `opam`  you can install desired ocaml version using command:

```
$ opam switch create 5.1.1
```

To use installed ocaml you need to type command given bellow. It configures
environment of current shell. It is good idea to add this command
to your `.bashrc` file.
```
$ eval $(opam env --switch=5.1.1) 
```

All dependencies can be installed using command:

```
$ opam install ocamlgraph menhir cmdliner dune ocamlformat
```


Building
--------

Use the following command:

```
$ make
```

The `Makefile` script will use `dune` command to build program and then create
symlink in the `install` directory.


Testing
-------

Use the following command:

```
$ make test
```

The `Makefile` script will execute `./scripts/tester.py` testing script.

You can select algorithm for data flow analyses by setting ALGORITHM Makefile variable.


```
$ make test ALGORITHM=my_solver
```

On a fresh installation some tests may fail as some analyses are not
implemented (they are left as exercises for students).
