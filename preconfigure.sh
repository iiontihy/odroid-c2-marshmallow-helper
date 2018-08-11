#!/bin/bash

export curdir=`pwd`

echo "--------------------------------------------------------------------------"
echo "------ getting u-boot toolchain ------"
export UBOOT_TC=$curdir/toolchain
mkdir -p $UBOOT_TC

wget -N https://releases.linaro.org/archive/14.09/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux.tar.xz

tar -C $UBOOT_TC -xvf ./gcc-linaro-aarch64-none-elf-4.9-2014.09_linux.tar.xz

echo "--------------------------------------------------------------------------"
echo "------ getting kernel toolchain ------"
export KERN_TC=$curdir/toolchain
mkdir -p $KERN_TC

wget -N http://releases.linaro.org/archive/14.09/components/toolchain/binaries/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux.tar.xz

tar -C $KERN_TC -xvf ./gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux.tar.xz

echo "--------------------------------------------------------------------------"
echo "------ getting OpenJDK 1.7 ------"
export OPENJDK_DIR=$curdir/openjdk7-7u171-x64
mkdir $OPENJDK_DIR

wget -N http://www.slackware.com/~alien/slackbuilds//openjdk7/pkg64/14.1/openjdk7-7u181_b01-x86_64-1alien.txz

tar -C $OPENJDK_DIR -xvf ./openjdk7-7u181_b01-x86_64-1alien.txz
                        
mv $OPENJDK_DIR/usr/share/* $OPENJDK_DIR
mv $OPENJDK_DIR/usr/lib64/java/* $OPENJDK_DIR
mkdir $OPENJDK_DIR/doc
mv $OPENJDK_DIR/usr/doc/openjdk7-7u181_b01/* $OPENJDK_DIR/doc
rm -rf $OPENJDK_DIR/usr

mv $OPENJDK_DIR/etc/java/jvm.cfg.new $OPENJDK_DIR/etc/java/jvm.cfg
mv $OPENJDK_DIR/etc/java/java.policy.new $OPENJDK_DIR/etc/java/java.policy
mv $OPENJDK_DIR/etc/java/java.security.new $OPENJDK_DIR/etc/java/java.security
mv $OPENJDK_DIR/etc/java/nss.cfg.new $OPENJDK_DIR/etc/java/nss.cfg
sed -ri 's/nssLibraryDirectory[^\n]+//' $OPENJDK_DIR/etc/java/nss.cfg

cd $OPENJDK_DIR/jre/lib/amd64
rm -rf jvm.cfg
cd $OPENJDK_DIR/jre/lib/amd64
ln -sf $OPENJDK_DIR/etc/java/jvm.cfg jvm.cfg
cd $OPENJDK_DIR/jre/lib/amd64/server
rm -rf libjsig.so
cd $OPENJDK_DIR/jre/lib/amd64/server
ln -sf ../libjsig.so libjsig.so
cd $OPENJDK_DIR/jre/lib/security
rm -rf java.security
cd $OPENJDK_DIR/jre/lib/security
ln -sf $OPENJDK_DIR/etc/java/java.security java.security
cd $OPENJDK_DIR/jre/lib/security
rm -rf java.policy
cd $OPENJDK_DIR/jre/lib/security
ln -sf $OPENJDK_DIR/etc/java/java.policy java.policy
cd $OPENJDK_DIR/jre/lib/security
rm -rf nss.cfg
cd $OPENJDK_DIR/jre/lib/security
ln -sf $OPENJDK_DIR/etc/java/nss.cfg nss.cfg
cd $OPENJDK_DIR/man
rm -rf ja.gz
cd $OPENJDK_DIR/man
ln -sf ja_JP.UTF-8.gz ja.gz

cd $curdir

echo "--------------------------------------------------------------------------"
echo "------ getting 'repo' ------"
mkdir ./repo
curl https://storage.googleapis.com/git-repo-downloads/repo > ./repo/repo
chmod 755 ./repo/repo







