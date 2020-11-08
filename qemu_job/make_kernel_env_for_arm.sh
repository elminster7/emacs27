#bin/sh
QEMU_DIR="QEMU_ENV"

if [ ! -d ~/QEMU ]; then
    mkdir ~/${QEMU_DIR}
    cd ~/${QEMU_DIR}
else
    echo "#### already qemu dir...."
fi

#sudo apt install -y gcc-aarch64-linux-gnu libglib2.0 libpixman-1-dev build-essential libssl-dev

build_qemu() {
    wget https://download.qemu.org/qemu-5.0.0.tar.xz ~/
    tar xf qemu-5.0.0.tar.xz
    cd qemu-5.0.0
    ./configure --target-list=aarch64-softmmu
    make -j $(nproc)
    make install
}
build_raspberry_kernel() {
    git clone -b rpi-5.6.y https://github.com/raspberrypi/linux.git linux-5.6
    cd linux-5.6
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make bcm2711_defconfig
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j $(nproc)
}

download_ubuntu_filesystem() {
    wget https://releases.linaro.org/debian/images/developer-arm64/18.04/linaro-stretch-developer-20180416-89.tar.gz
}

prepare_compress_image() {
    if [ ! -f aarch64-laptops-bionic-prebuilt.img ]; then
        wget https://releases.linaro.org/aarch64-laptops/images/ubuntu/18.04/aarch64-laptops-bionic-prebuilt.img.xz
        xz -d $QEMU_DIR/aarch64-laptops-bionic-prebuilt.img.xz
    fi

    FILESYSTEM=aarch64-laptops-bionic-prebuilt.img
    EFI=`fdisk -l $PWD/$FILESYSTEM | grep EFI | awk '{print $2}'`
    Linux=`fdisk -l $PWD/$FILESYSTEM | grep Linux | awk '{print $2}'`
    EFI_SIZE=`expr $EFI \* 512`
    Linux_Size=`expr $Linux \* 512`

    dd if=/dev/zero of=rootfs.ext4 bs=1M count=8000

    mkfs.ext4 rootfs.ext4

    if [ ! -d ~/$QEMU_DIR/mnt2 ]; then
        mkdir -p ~/$QEMU_DIR/mnt2 ~/$QEMU_DIR/rootfs
        sudo mount -v -o offset=$Linux_Size -t ext4 $FILESYSTEM ~/$QEMU_DIR/mnt2
        sudo mount -o loop rootfs.ext4 ~/$QEMU_DIR/rootfs
        sudo cp -rf ~/$QEMU_DIR/mnt2/* ~/$QEMU_DIR/rootfs/
    fi

    sudo umount mnt2
    sudo umount rootfs
}

if [ -e /usr/local/bin/qemu-system-aarch64 ]; then
    echo "#### skipped qemu utility build....."
else
    build_qemu
fi

if [ ! -d ~/${QEMU_DIR}/linux-5.6 ]; then
    build_raspberry_kernel
else
    echo "#### downloaded already linux kernel...."
fi


#download_ubuntu_filesystem
prepare_compress_image
