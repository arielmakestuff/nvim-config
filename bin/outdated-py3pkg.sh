#! /bin/sh
#
# outdated-py3pkg.sh
# Copyright (C) 2019 smokybobo <smokybobo@yui>
#
# Distributed under terms of the MIT license.
#

# This script depends on the jq tool being found on $PATH

poetry run python -m pip list -o --format json \
    | jq --raw-output '.[].name'
