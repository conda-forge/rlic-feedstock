#!/usr/bin/env bash
set -ex

export CARGO_PROFILE_RELEASE_STRIP=symbols

PLATFORM=$(uname)
ARCH=$(uname -m)

if [ $ARCH == 'x86_64' ] ; then
  if [ $PLATFORM == 'Darwin' ] ; then
    MATURIN_BUILD_ARGS="--no-default-features"
  elif [ $PLATFORM == "Linux" ] ; then
    MATURIN_BUILD_ARGS="--no-default-features -F branchless"
  fi
fi
MATURIN_BUILD_ARGS="$MATURIN_BUILD_ARGS --release"

cargo-bundle-licenses \
  --format yaml \
  --output "${SRC_DIR}/THIRDPARTY.yml"

maturin build $MATURIN_BUILD_ARGS
$PYTHON -m pip install target/wheels/rlic-*.whl -vv
