#bin/sh
sudo apt install -y gcc-aarch64-linux-gnu libglib2.0 libpixman-1-dev build-essential libssl-dev

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
    wget https://releases.linaro.org/aarch64-laptops/images/ubuntu/18.04/aarch64-laptops-bionic-prebuilt.img.xz
    tar xf aarch64-laptops-bionic-prebuilt.img.xz
}

#build_qemu
#build_raspberry_kernel
download_ubuntu_filesystem
