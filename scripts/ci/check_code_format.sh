# #!/bin/bash -ue

# set -o errexit
# set -o pipefail
# set -o nounset

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd "$SCRIPT_DIR/../../"

# ./scripts/dev/clang-format-all.sh
# echo "Linting done"

# cd libs/openFrameWorks
# dirty=$(git ls-files --modified)

# echo "Linting done"
# if [[ $dirty ]]; then
#     echo "Files not properly formatted. The following files need to be formatted:"
#     echo $dirty
#     echo
#     echo "$(git diff)"
#     exit 1
# fi

#!/bin/bash
#
# Script to determine if .js files in Pull Request are properly formatted.
# Exits with non 0 exit code if formatting is needed.

FILES_TO_CHECK=$(git diff --name-only master | grep -E "\.cpp$")

if [ -z "${FILES_TO_CHECK}" ]; then
  echo "No files to check for formatting."
  exit 0
fi
echo "$FILES_TO_CHECK"
FORMAT_DIFF=$(git diff -U0 master -- ${FILES_TO_CHECK} |
              ../clang/share/clang/clang-format-diff.py -p1)

if [ -z "${FORMAT_DIFF}" ]; then
  # No formatting necessary.
  echo "All files in PR properly formatted."
  exit 0
else
  # Found diffs.
  echo "ERROR: Found formatting errors!"
  echo "${FORMAT_DIFF}"
  exit 1
fi
