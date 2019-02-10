#! /bin/sh
#
# install-py3pkg.sh
# Copyright (C) 2019 smokybobo <smokybobo@yui>
#
# Distributed under terms of the MIT license.
#

# This script accepts a single argument: path to python executable

NVIM_DIR=$(dirname $0)/..
PY_BIN=$1

$PY_BIN -m pip install -U -r $NVIM_DIR/config/py3pkg.txt
