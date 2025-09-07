#!/usr/bin/env bash

# https://github.com/jesperhh/qmlfmt
find . -name "*.qml" -exec qmlfmt -t 4 -i 4 -w {} \;
