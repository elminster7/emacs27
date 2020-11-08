#!/bin/sh
WORK_DIR=${HOME}"/workspace"
KERNEL_DIR=${WORK_DIR}"/lsk-4.9"
KERNEL_IMG=${KERNEL_DIR}"/arch/arm64/boot/Image"
ROOTFS="vexpress64-openembedded_lamp-armv8-gcc-4.9_20150725-725.img"
DTB_FILE="virt.dtb"

qemu-system-aarch64 -smp 2 -m 1024 -cpu cortex-a72 -nographic \
        -machine virt \
        -kernel Image \
        -append 'root=/dev/vda rw rootwait mem=1024M console=ttyAMA0,38400n8' \
        -device virtio-blk-device,drive=disk \
        -drive if=none,id=disk,file=rootfs.ext4,format=raw
reset
