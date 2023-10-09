echo Search directory is %DEV_DIR%

set SELECTED=ls %DEV_DIR% | fzf

echo Selected directory is %SELECTED%
