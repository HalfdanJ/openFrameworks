#!/bin/bash -ue

set -o errexit
set -o pipefail
set -o nounset

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/../../"

./scripts/dev/clang-format-all.sh

cd libs/openFrameWorks
dirty=$(git ls-files --modified)

if [[ $dirty ]]; then
    echo "Files not properly formatted. The following files need to be formatted:"
    echo $dirty
    echo
    echo "$(git diff)"
    exit 1
fi
