#!/usr/bin/env bash
set -eux

export CARGO_PROFILE_RELEASE_STRIP=symbols

PLATFORM=$(uname)
ARCH=$(uname -m)


MATURIN_BUILD_ARGS="--release -F pyo3/abi3-py311"
if [ $ARCH == 'x86_64' ] ; then
  MATURIN_BUILD_ARGS="$MATURIN_BUILD_ARGS --no-default-features"
fi

cargo-bundle-licenses \
  --format yaml \
  --output "${SRC_DIR}/THIRDPARTY.yml"

maturin build $MATURIN_BUILD_ARGS
$PYTHON -m pip install rlic --find-links target/wheels -vv
