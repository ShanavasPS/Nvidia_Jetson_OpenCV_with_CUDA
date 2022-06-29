#!/bin/bash

set -euf -o pipefail

# OpenCV defines
OPENCV_VERSION=4.1.1
ARCH_BIN=5.3 # Jetson Nano
CUDNN_VERSION=8.2
NUM_JOBS=$(nproc)
OPENCV_DOWNLOAD_DIR=/home/opencv
OPENCV_DIR=opencv-$OPENCV_VERSION
OPENCV_CONTRIB_DIR=opencv_contrib-$OPENCV_VERSION
OPENCV_BUILD_DIR=$OPENCV_DIR/build
OPENCV_GITHUB_REPO=https://github.com/opencv
OPENCV_REPO=$OPENCV_GITHUB_REPO/opencv/archive/refs/tags/$OPENCV_VERSION.tar.gz
OPENCV_CONTRIB_REPO=$OPENCV_GITHUB_REPO/opencv_contrib/archive/refs/tags/$OPENCV_VERSION.tar.gz
OPENCV_INSTALL_LOCATION=/usr

# Compile and Install OpenCV with CUDA
echo "Downloading and compiling OpenCV with CUDA support"

sudo apt install -y cmake libavcodec-dev libavformat-dev libavutil-dev libeigen3-dev libglew-dev libgtk2.0-dev libgtk-3-dev libjpeg-dev libpng-dev libpostproc-dev libswscale-dev libtbb-dev libtiff5-dev libv4l-dev libxvidcore-dev libx264-dev qt5-default zlib1g-dev python-dev python-numpy python-py python-pytest python3-dev python3-py python3-pytest libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev    

mkdir $OPENCV_DOWNLOAD_DIR
cd $OPENCV_DOWNLOAD_DIR
wget $OPENCV_REPO
tar -xf $OPENCV_VERSION.tar.gz
sudo rm $OPENCV_VERSION.tar.gz
wget $OPENCV_CONTRIB_REPO
tar -xf $OPENCV_VERSION.tar.gz
sudo rm $OPENCV_VERSION.tar.gz

# Create the build directory and start cmake
mkdir $OPENCV_DOWNLOAD_DIR/$OPENCV_BUILD_DIR

cd $OPENCV_DOWNLOAD_DIR/$OPENCV_BUILD_DIR
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=${OPENCV_INSTALL_LOCATION} \
      -D WITH_CUDA=ON \
      -D WITH_CUDNN=ON \
      -D CUDNN_VERSION=${CUDNN_VERSION} \
      -D CUDA_ARCH_BIN=${ARCH_BIN} \
      -D CUDA_ARCH_PTX="" \
      -D ENABLE_FAST_MATH=ON \
      -D CUDA_FAST_MATH=ON \
      -D WITH_CUBLAS=ON \
      -D WITH_LIBV4L=ON \
      -D WITH_V4L=ON \
      -D WITH_GSTREAMER=ON \
      -D WITH_GSTREAMER_0_10=OFF \
      -D WITH_QT=OFF \
      -D WITH_GTK=ON \
      -D WITH_GTK_2_X=ON \
      -D WITH_OPENGL=ON \
      -D BUILD_opencv_python2=ON \
      -D BUILD_opencv_python3=ON \
      -D BUILD_TESTS=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D OPENCV_GENERATE_PKGCONFIG=YES \
      -D OPENCV_EXTRA_MODULES_PATH=../../${OPENCV_CONTRIB_DIR}/modules \
      -D CPACK_PACKAGE_VERSION=${OPENCV_VERSION} \
      -D EXTRAMODULES_VCSVERSION=${OPENCV_VERSION} \
      -D OPENCV_VCSVERSION=${OPENCV_VERSION} \
      ../
      make -j${NUM_JOBS}
      make install
      ldconfig

echo "OpenCV installed in: $OPENCV_INSTALL_LOCATION"
sudo rm -rf $OPENCV_DOWNLOAD_DIR
