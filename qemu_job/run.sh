#!/bin/sh
WORK_DIR=${HOME}"/008_QEMU"
KERNEL_DIR=${WORK_DIR}"/linux-5.6"
KERNEL_IMG=${KERNEL_DIR}"/arch/arm64/boot/Image"
ROOTFS="rootfs.ext4"
DTB_FILE="virt.dtb"

if [ 1 == 0 ]; then
qemu-system-aarch64 -smp 2 -m 1024 -cpu cortex-a57 -nographic \
        -machine virt,dumpdtb=virt_original.dtb \
        -kernel ${KERNEL_IMG} \
        -append 'root=/dev/vda rw rootwait mem=1024M console=ttyAMA0,38400n8' \
        -device virtio-net-device,netdev=mynet1 \
        -netdev tap,id=mynet1,ifname=tap0,br=virbr0,script=no,downscript=no \
        -device virtio-blk-device,drive=disk \
        -drive if=none,id=disk,file=${ROOTFS},format=raw
else
qemu-system-aarch64 -smp 2 -m 1024 -cpu cortex-a72 -nographic \
        -machine virt \
        -kernel ${KERNEL_IMG} \
        -append 'root=/dev/vda rw rootwait mem=1024M console=ttyAMA0,38400n8' \
        -device virtio-blk-device,drive=disk \
        -drive if=none,id=disk,file=${ROOTFS},format=raw
fi
reset

        #-dtb ${DTB_FILE} 
 #       -device virtio-net-device,netdev=mynet1
 #       -netdev tap,id=mynet1,ifname=tap0,br=virbr0,script=no,downscript=no
 #       -device virtio-blk-device,drive=disk
