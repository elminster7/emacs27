#bin/sh
KERNEL_VER="5.10"
QEMU_VER="6.0.0"
ROOTFS="aarch64-laptops-bionic-prebuilt.img.xz"

#===========================================================
# requirement packages install.
#===========================================================
sudo apt install -y gcc-aarch64-linux-gnu libglib2.0-0 \
     libpixman-1-dev build-essential libssl-dev ninja-build


#===========================================================
# install qemu
#===========================================================
build_qemu() {
    wget https://download.qemu.org/qemu-${QEMU_VER}.tar.xz ~/
    tar xf qemu-${QEMU_VER}.tar.xz
    cd qemu-${QEMU_VER}
    ./configure --target-list=aarch64-softmmu
    make -j $(nproc)
    make install
}

build_raspberry4_kernel() {
    #git clone -b rpi-${KERNEL_VER}.y https://github.com/raspberrypi/linux.git linux-${KERNEL_VER}
    #cd linux-${KERNEL_VER}
    #ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make bcm2711_defconfig
    #ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j $(nproc)
    git clone https://github.com/iamroot18/${KERNEL_VER}
    cd linux-${KERNEL_VER}
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j $(nproc)
}

prepare_compress_image() {
    if [ ! -e aarch64-laptops-bionic-prebuilt.img.xz ]; then
        wget https://releases.linaro.org/aarch64-laptops/images/ubuntu/18.04/${ROOTFS}
    fi

    #tar xf "${ROOTFS}"
    unxz $PWD/${ROOTFS}
    FILESYSTEM=aarch64-laptops-bionic-prebuilt.img
    EFI=`fdisk -l $PWD/$FILESYSTEM | grep EFI | awk '{print $2}'`
    Linux=`fdisk -l $PWD/$FILESYSTEM | grep Linux | awk '{print $2}'`
    EFI_SIZE=`expr $EFI \* 512`
    Linux_Size=`expr $Linux \* 512`

    mkdir mnt1 mnt2
    sudo mount -v -o offset=$EFI_SIZE -t vfat $FILESYSTEM mnt1
    sudo umount mnt1
    sudo mount -v -o offset=$Linux_Size -t ext4 $FILESYSTEM mnt2
    cd mnt2/
    sudo tar cfv bio_rootfs.tar.gz *
}

make_rootfs_ext() {
	dd if=/dev/zero of=rootfs.ext4 bs=1M count=16000
	mkfs.ext4 -F rootfs.ext4
	sudo mount rootfs.ext4 mnt1 -o loop
	cd mnt2/
	sudo tar xf bio_rootfs.tar.gz -C ../mnt1
}

build_qemu
build_raspberry4_kernel
prepare_compress_image
make_rootfs_ext
