#!/bin/bash

declare -r CLANG_VERSION="6.0.0"
declare -r CLANG_BUILD="clang+llvm-${CLANG_VERSION}-x86_64-linux-gnu-ubuntu-14.04"
declare -r CLANG_TAR="${CLANG_BUILD}.tar.xz"
declare -r CLANG_URL="http://llvm.org/releases/${CLANG_VERSION}/${CLANG_TAR}"


set -ex

cd ..

# Install clang-format.
wget --quiet $CLANG_URL
tar xf $CLANG_TAR
mv $CLANG_BUILD clang
rm -f $CLANG_TAR