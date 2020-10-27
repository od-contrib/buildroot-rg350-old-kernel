#!/bin/sh

# Builds a full SD card image
#
# If you want the localpack apps included in the image, run this first:
# board/opendingux/gcw0/download_local_pack.sh

set -e

if [ $# -ne 1 ]; then
	echo "Usage: $0 <target device>"
	exit 64
fi

TARGET_PLATFORM=rg350
TARGET_DEVICE="$1"

# Buildroot will build to ./output by default but we have multiple builds
OUTPUT_DIR=output-${TARGET_DEVICE}

# First, build the linux kernel (it uses older gcc)
KERNEL_DIR=output-kernel-${TARGET_DEVICE}
if ! [ -f ${KERNEL_DIR}/images/vmlinuz.bin ]; then
	board/opendingux/gcw0/build_kernel.sh $TARGET_DEVICE $KERNEL_DIR
fi
echo "Will use linux kernel from ./${KERNEL_DIR}"

make "${TARGET_DEVICE}_defconfig" BR2_EXTERNAL=board/opendingux:opks O=$OUTPUT_DIR
make world mininit host-od-imager O=$OUTPUT_DIR

# Data image (OPKs):
cd ${OUTPUT_DIR}/images
mkdir -p od-imager/apps/
rm -f od-imager/apps/*
if [ -d ../../dl/od_local_pack/ ]; then
	cp ../../dl/od_local_pack/*.opk od-imager/apps/
fi
if [ -d ../../dl/od_local_pack/${TARGET_DEVICE} ]; then
	cp ../../dl/od_local_pack/${TARGET_DEVICE}/*.opk od-imager/apps/
fi
if [ -d opks ]; then
	cp opks/*.opk od-imager/apps/
fi

# System image
cp mininit-syspart od-imager/
cp ../../${KERNEL_DIR}/images/vmlinuz.bin ../../${KERNEL_DIR}/images/modules.squashfs od-imager/
cp rootfs.squashfs od-imager/
# Fallbacks are empty as this is the initial image.
echo -n > od-imager/vmlinuz.bak
echo -n > od-imager/modules.squashfs.bak

# Bootloader
cp "ubiboot/ubiboot-${TARGET_PLATFORM}.bin" od-imager/ubiboot.bin
cd -

# Assemble partitions and the final image
cd ${OUTPUT_DIR}/images/od-imager/
./create_mbr.sh
./create_system_image.sh
./create_data_image.sh
./assemble_images.sh
cd -

echo
echo 'SD card image created in:'
echo ${OUTPUT_DIR}/images/od-imager/images/sd_image.bin
echo Size:
du -sh ${OUTPUT_DIR}/images/od-imager/images/sd_image.bin

echo 'Renaming and compressing...'
NAME="${TARGET_DEVICE}-$(date +'%Y-%m-%d')$(support/scripts/setlocalversion)"
cp ${OUTPUT_DIR}/images/od-imager/images/sd_image.bin "${OUTPUT_DIR}/images/${NAME}.bin"
zip "${OUTPUT_DIR}/images/${NAME}.zip" "${OUTPUT_DIR}/images/${NAME}.bin"
rm "${OUTPUT_DIR}/images/${NAME}.bin"
du -sh "${OUTPUT_DIR}/images/${NAME}.zip"
