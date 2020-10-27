#!/bin/sh

set -e
set -x

time board/opendingux/gcw0/make_initial_image.sh rg350
make sdk O=output-rg350

time board/opendingux/gcw0/make_initial_image.sh rg350m
make sdk O=output-rg350m
