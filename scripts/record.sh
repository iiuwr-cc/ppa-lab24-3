#!/bin/sh

set -e

tools_dir=$(dirname $(realpath $0))
base_dir=$(dirname $tools_dir)

if [ $(basename $tools_dir) != "scripts" ]
then
    echo "Założenia skryptu nie zgadzają się z rzeczywistością."
    echo "Skrypt zakłada, że znajduje się w podkatalogu scripts"
    echo "katalogu zawierającego kod źródłowy apk."
    exit 0
fi


APK="$base_dir/install/apk"
EMBED="$tools_dir/embed.sh"

if [ "$#" != "3" ]
then
    echo "usage: $0 [code_file] [language] [analysis_name]"
    exit 1
fi

code="$1"
language="$2"
analysis="$3"

tmp_code=`mktemp`
tmp_table=`mktemp`

${APK} "${language}" "simplify" "${code}" -o "${tmp_code}"
${APK} "${language}" "analyse" "${analysis}" "${tmp_code}" -t "${tmp_table}"
${EMBED} "${tmp_code}" "${language}" "${analysis}" "${tmp_table}"
rm -f "${tmp_code}" "${tmp_table}"
