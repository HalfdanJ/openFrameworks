#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

OF_ROOT="../.."

for DIRECTORY in "$OF_ROOT/libs/openFrameworks" "$OF_ROOT/examples" 
do
    echo "Formatting code under $DIRECTORY/"
    find "$DIRECTORY" \( -name '*.h' -or -name '*.m' -or -name '*.cpp' -or -name '*.mm' \) -print0 | xargs -0 clang-format -i
done