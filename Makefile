.PHONY: all compile install test clean 

all: install

install: compile
	mkdir -p install
	rm -f ./install/apk
	ln -s ../_build/install/default/bin/apk ./install/apk

compile:
	dune build

test:
	TESTER_FLAGS=""; if [ ! -z "${ALGORITHM}" ]; then TESTER_FLAGS="--algorithm ${ALGORITHM}"; fi; ./scripts/tester.py $${TESTER_FLAGS}

clean:
	dune clean

