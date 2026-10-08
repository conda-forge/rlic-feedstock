@echo on

set CARGO_PROFILE_RELEASE_STRIP=symbols

REM Create temp folder
mkdir tmpbuild_%PY_VER%
set TEMP=%CD%\tmpbuild_%PY_VER%
REM Bundle all downstream library licenses
cargo-bundle-licenses ^
    --format yaml ^
    --output %SRC_DIR%\THIRDPARTY.yml ^
    || goto :error
popd

set PYTHONUTF8=1
set PYTHONIOENCODING="UTF-8"
set TMPDIR=tmpbuild_%PY_VER%
maturin build -F pyo3/abi3-py311
%PYTHON% -m pip install rlic --find-links target\wheels -vv
