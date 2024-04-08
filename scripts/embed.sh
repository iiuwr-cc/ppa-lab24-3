#!/bin/sh

set -e

if [ "$#" != "4" ]
then
    echo "usage: $0 [code file] [language_name] [analysis_name] [expected table]"
    exit 1
fi

code="$1"
language="$2"
analysis="$3"
table="$4"

cat ${code}
echo ""
echo "//@PRACOWNIA"
echo "//@analysis ${analysis}"
echo "//@language ${language}"
cat ${table} | sed -e 's/^/\/\/@ /'
