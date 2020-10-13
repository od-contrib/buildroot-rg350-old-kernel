#!/bin/sh

# Builds the linux kernel and modules only

set -e

if [ $# -ne 1 ]; then
	echo "Usage: $0 <target device>"
	exit 64
fi

TARGET_PLATFORM=rg350
TARGET_DEVICE="$1"

echo 'Building Linux kernel'

set -x
make "${TARGET_DEVICE}_kernel_only_defconfig" BR2_EXTERNAL=board/opendingux
make linux
board/opendingux/gcw0/build-linux-modules-squashfs.sh output/images/
