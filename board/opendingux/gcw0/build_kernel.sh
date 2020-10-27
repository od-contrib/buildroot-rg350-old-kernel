#!/bin/sh

# Builds the linux kernel and modules only

set -e

if [ $# -lt 1 ]; then
	echo "Usage: $0 <target device> [<output dir>]"
	exit 64
fi

TARGET_PLATFORM=rg350
TARGET_DEVICE="$1"

if [ $# -gt 1 ]; then
	KERNEL_DIR=$2
else
	KERNEL_DIR=output-kernel-${TARGET_DEVICE}
fi

echo 'Building Linux kernel'

set -x
make "${TARGET_DEVICE}_kernel_only_defconfig" BR2_EXTERNAL=board/opendingux O=$KERNEL_DIR
make linux O=$KERNEL_DIR

# Build modules.squashfs
eval $(make -s printvars VARS=LINUX_DIR QUOTED_VARS=YES O=$KERNEL_DIR)
if [ -f "${LINUX_DIR}/create_modules_fs.sh" ]; then
  "${LINUX_DIR}/create_modules_fs.sh"
  cp "${LINUX_DIR}/modules.squashfs" "${KERNEL_DIR}/images/"
else
  echo "modules.squashfs not built because ${LINUX_DIR}/create_modules_fs.sh is missing"
	exit 1
fi
