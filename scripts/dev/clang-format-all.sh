#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

OF_ROOT="../.."

if type clang-format-7 2> /dev/null ; then
    CLANG_FORMAT=clang-format-7
elif type clang-format 2> /dev/null ; then
    CLANG_FORMAT=clang-format
else 
    echo "No appropriate clang-format found (expected clang-format-7, or clang-format)"
    exit 1
fi

for DIRECTORY in "$OF_ROOT/libs/openFrameworks"
do
    echo "Formatting code under $DIRECTORY/"
    find "$DIRECTORY" \( -name '*.h' -or -name '*.m' -or -name '*.cpp' -or -name '*.mm' \) -print0 | xargs -0 ${CLANG_FORMAT} -i
done