#!/bin/sh

## 1
#sudo apt-get -y install autoconf automake build-essential libass-dev libtool pkg-config texinfo zlib1g-dev libva-dev cmake mercurial libdrm-dev libvorbis-dev libogg-dev git libx11-dev libperl-dev libpciaccess-dev libpciaccess0 xorg-dev intel-gpu-tools opencl-headers libwayland-dev xutils-dev ocl-icd-* libssl-dev

## 2
#sudo add-apt-repository ppa:oibaf/graphics-drivers
#sudo apt-get update

## 3
#mkdir -p ~/vaapi
#mkdir -p ~/ffmpeg_build
#mkdir -p ~/ffmpeg_sources
#mkdir -p ~/bin

## 4
compile_libva() {
    cd ~/vaapi
    git clone https://github.com/01org/libva
    cd libva
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
    time make -j$(nproc) VERBOSE=1
    sudo make -j$(nproc) install
}

#compile_libva

compile_gmmlib() {
    mkdir -p ~/vaapi/workspace
    cd ~/vaapi/workspace
    git clone https://github.com/intel/gmmlib
    mkdir -p build
    cd build
    cmake -DCMAKE_BUILD_TYPE= Release ../gmmlib
    make -j$(nproc)
    sudo make -j$(nproc) install 
}

#compile_gmmlib

## 5
compile_intel_media_driver() {
    cd ~/vaapi/workspace
    git clone https://github.com/intel/media-driver
    cd media-driver
    git submodule init
    git pull
    mkdir -p ~/vaapi/workspace/build_media
    cd ~/vaapi/workspace/build_media
    cmake ../media-driver \
	  -DBS_DIR_GMMLIB=$PWD/../gmmlib/Source/GmmLib/ \
	  -DBS_DIR_COMMON=$PWD/../gmmlib/Source/Common/ \
	  -DBS_DIR_INC=$PWD/../gmmlib/Source/inc/ \
	  -DBS_DIR_MEDIA=$PWD/../media-driver \
	  -DCMAKE_INSTALL_PREFIX=/usr \
	  -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu \
	  -DINSTALL_DRIVER_SYSCONF=OFF \
	  -DLIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri
    time make -j$(nproc) VERBOSE=1
    sudo make -j$(nproc) install VERBOSE=1
    sudo usermod -a -G video $USER
    sudo echo "LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri" >> /etc/environment
    sudo echo "LIBVA_DRIVER_NAME=i965" >> /etc/environment
}

#compile_intel_media_driver

## 6
compile_cmrt() {
    cd ~/vaapi
    git clone https://github.com/01org/cmrt
    cd cmrt
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
    time make -j$(nproc) VERBOSE=1
    sudo make -j$(nproc) install
}

#compile_cmrt

## 7
compile_intel_hybrid_driver() {
    cd ~/vaapi
    git clone https://github.com/01org/intel-hybrid-driver
    cd intel-hybrid-driver
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
    time make -j$(nproc) VERBOSE=1
    sudo make -j$(nproc) install
}

#compile_intel_hybrid_driver

## 8
compile_intel_vaapi_driver() {
    cd ~/vaapi
    git clone https://github.com/01org/intel-vaapi-driver
    cd intel-vaapi-driver
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu --enable-hybrid-codec
    time make -j$(nproc) VERBOSE=1
    sudo make -j$(nproc) install
}

#compile_intel_vaapi_driver

## 9
compile_libva_utils() {
    cd ~/vaapi
    git clone https://github.com/intel/libva-utils
    cd libva-utils
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
    time make -j$(nproc) VERBOSE=1
    sudo make -j$(nproc) install
}

#compile_libva_utils

## 10
imsdk_package_before_install() {
    sudo add-apt-repository ppa:intel-opencl/intel-opencl
    sudo apt-get update
    sudo apt install intel-gmmlib intel-gpu-tools intel-microcode intel-opencl intel-cmt-cat intel-gmmlib-dev intel-ocloc intel-opencl-icd
    #intel-cloc
}

#imsdk_package_before_install

## 11
## refer to https://qastack.kr/ubuntu/850281/opencl-on-ubuntu-16-04-intel-sandy-bridge-cpu
install_opencl_on_intel() {
    sudo apt -y install ocl-icd-libopencl1 opencl-headers clinfo beignet rpm alien libnuma1
}

#install_opencl_on_intel

compile_intel_msdk() {
    cd ~/vaapi
    git clone https://github.com/Intel-Media-SDK/MediaSDK msdk
    cd msdk
    git submodule init
    git pull
    mkdir -p ~/vaapi/build_msdk
    cd ~/vaapi/build_msdk
    cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_WAYLAND=ON -DENABLE_X11_DRI3=ON -DENABLE_OPENCL=ON  ../msdk
    time make -j$(nproc) VERBOSE=1
    sudo make install -j$(nproc) VERBOSE=1
    sudo touch /etc/ld.so.conf.d/imsdk.conf
    sudo echo "/opt/intel/mediasdk/lib" > /etc/ld.so.conf.d/imsdk.conf
    sudo ldconfig
}

#compile_intel_msdk

build_nasm() {
    cd ~/ffmpeg_sources
    wget wget http://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.gz
    tar xzvf nasm-2.14.02.tar.gz
    cd nasm-2.14.02
    ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" 
    make -j$(nproc) VERBOSE=1
    make -j$(nproc) install
    make -j$(nproc) distclean
}

#build_nasm

build_libx264() {
    cd ~/ffmpeg_sources
    git clone http://git.videolan.org/git/x264.git 
    cd x264/
    PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --enable-static --enable-pic --bit-depth=all
    PATH="$HOME/bin:$PATH" make -j$(nproc) VERBOSE=1
    make -j$(nproc) install VERBOSE=1
    make -j$(nproc) distclean
}
#build_libx264

build_libx265() {
    cd ~/ffmpeg_sources
    git clone https://github.com/videolan/x265.git
    cd ~/ffmpeg_sources/x265/build/linux
    PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
    make -j$(nproc) VERBOSE=1
    make -j$(nproc) install VERBOSE=1
    make -j$(nproc) clean VERBOSE=1
}
#build_libx265

build_libfdk_aac() {
    cd ~/ffmpeg_sources
    git clone https://github.com/mstorsjo/fdk-aac
    cd fdk-aac
    autoreconf -fiv
    ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
    make -j$(nproc)
    make -j$(nproc) install
    make -j$(nproc) distclean
}
#build_libfdk_aac

build_libvpx() {
    cd ~/ffmpeg_sources
    git clone https://github.com/webmproject/libvpx
    cd libvpx
    ./configure --prefix="$HOME/ffmpeg_build" --enable-runtime-cpu-detect --cpu=native --as=nasm --enable-vp8 --enable-vp9 \
		--enable-postproc-visualizer --disable-examples --disable-unit-tests --enable-static --disable-shared \
		--enable-multi-res-encoding --enable-postproc --enable-vp9-postproc \
		--enable-vp9-highbitdepth --enable-pic --enable-webm-io --enable-libyuv 
    time make -j$(nproc)
    time make -j$(nproc) install
    time make clean -j$(nproc)
    time make distclean
}

#build_libvpx

build_libvorbis() {
    cd ~/ffmpeg_sources
    git clone https://github.com/xiph/vorbis.git
    cd vorbis
    autoreconf -ivf
    ./configure --enable-static --prefix="$HOME/ffmpeg_build"
    time make -j$(nproc)
    time make -j$(nproc) install
    time make clean -j$(nproc)
    time make distclean
}
#build_libvorbis

build_libsdl() {
    cd ~/ffmpeg_sources
    hg clone http://hg.libsdl.org/SDL
    cd ~/ffmpeg_sources/SDL
    ./autogen.sh -ivf
    PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --with-x --with-pic=yes \
	--disable-alsatest --enable-pthreads --enable-static=yes --enable-shared=no
    make -j$(nproc) VERBOSE=1
    make -j$(nproc) install VERBOSE=1
    make -j$(nproc) clean VERBOSE=1
}

#build_libsdl

build_ffmpeg() {
    cd ~/ffmpeg_sources
#    git clone https://github.com/FFmpeg/FFmpeg -b master
    cd FFmpeg
    PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig:/opt/intel/mediasdk/lib/pkgconfig" ./configure \
	--pkg-config-flags="--static" \
	--enable-static --disable-shared \
	--prefix="$HOME/ffmpeg_build" \
	--bindir="$HOME/bin" \
	--enable-libmfx \
	--extra-cflags="-I$HOME/ffmpeg_build/include" \
	--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
	--extra-cflags="-I/opt/intel/mediasdk/include" \
	--extra-ldflags="-L/opt/intel/mediasdk/lib" \
	--extra-ldflags="-L/opt/intel/mediasdk/plugins" \
	--enable-vaapi \
	--enable-opencl \
	--disable-debug \
	--enable-libvorbis \
	--enable-libvpx \
	--enable-libdrm \
	--enable-gpl \
	--enable-runtime-cpudetect \
	--enable-libfdk-aac \
	--enable-libx264 \
	--enable-libx265 \
	--enable-openssl \
	--enable-pic \
	--extra-libs="-lpthread -lm -lz -ldl" \
	--enable-nonfree 
    PATH="$HOME/bin:$PATH" make -j$(nproc) 
    make -j$(nproc) install 
    make -j$(nproc) distclean 
    hash -r
}
build_ffmpeg



# libmfx
# refer to https://blog.djjproject.com/253
