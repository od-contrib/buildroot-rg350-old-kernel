#!/bin/sh

set -e
set -x

time board/opendingux/gcw0/make_initial_image.sh rg350
rm -rf output-rg350
mv output output-rg350

time board/opendingux/gcw0/make_initial_image.sh rg350m
rm -rf output-rg350m
mv output output-rg350m
