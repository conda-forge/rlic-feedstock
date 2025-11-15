#!/usr/bin/env bash
set -eux

export CARGO_PROFILE_RELEASE_STRIP=symbols

PLATFORM=$(uname)
ARCH=$(uname -m)


MATURIN_BUILD_ARGS="--release"
if [ $ARCH == 'x86_64' ] ; then
  MATURIN_BUILD_ARGS="$MATURIN_BUILD_ARGS --no-default-features -F fma"
fi

cargo-bundle-licenses \
  --format yaml \
  --output "${SRC_DIR}/THIRDPARTY.yml"

maturin build $MATURIN_BUILD_ARGS
$PYTHON -m pip install target/wheels/rlic-*.whl -vv
