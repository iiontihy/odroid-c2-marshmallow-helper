#!/bin/bash

export curdir=`pwd`

cd ./marshmallow

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
export PATH=$curdir/toolchain/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:$PATH
export PATH=$curdir/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux/bin:$PATH
export JAVA_HOME=$curdir/openjdk7-7u171-x64/
export PATH=$JAVA_HOME/bin:$PATH
#fix lexer crash
export LC_ALL=C

source build/envsetup.sh
lunch odroidc2-eng-32
make clean
make -j 1 selfinstall
                            