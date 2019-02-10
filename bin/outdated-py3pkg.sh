#! /bin/sh
#
# outdated-py3pkg.sh
# Copyright (C) 2019 smokybobo <smokybobo@yui>
#
# Distributed under terms of the MIT license.
#

# This script accepts a single argument: path to python executable

PY_BIN=$1

$PY_BIN -m pip list -o --format json \
    | jq --raw-output '.[].name'
