#!/bin/bash

export curdir=`pwd`

mkdir marshmallow
cd marshmallow
export PATH=$PATH:$curdir/repo

# replace the variables below with your account info if you need to
git config --global user.email "anonymous@gmail.com"
git config --global user.name "anonymous"

repo init -u https://github.com/hardkernel/android.git -b s905_6.0.1_master
repo sync
repo start s905_6.0.1_master --all

$curdir/apply_repo_diff.sh $curdir $curdir/marshmallow