#!/usr/bin/env bash

set -e

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -z "$MKN_MAKE_THREADS" ] && MKN_MAKE_THREADS="$(nproc --all)"

CURL="curl-7.63.0"

GZ_FILE="${CURL}.tar.gz"

[ ! -f "$GZ_FILE" ] && wget https://curl.haxx.se/download/${GZ_FILE}

[ ! -d "$CURL" ] && tar xf $GZ_FILE

rm -rf build
mkdir -p build

pushd $CWD/build

cmake -DCMAKE_INSTALL_PREFIX=$CWD/inst -DCMAKE_BUILD_TYPE=Release ../$CURL

make -j${MKN_MAKE_THREADS}
make install

popd

rm -rf $CWD/build
