#!/bin/sh

set -x

TOOLCHAIN_DIR=/opt/projects/LFS/.output/tools
#LFS_TGT=${TOOLCHAIN_DIR}/bin/
LFS_TGT=x86_64-aaeon-linux-gnu
export PATH=${TOOLCHAIN_DIR}/bin:${PATH}


#export LIBRARY_PATH=${TOOLCHAIN_DIR}/lib:$LIBRARY_PATH

echo 'int main(){}' > dummy.c
${LFS_TGT}-gcc  dummy.c
readelf -l a.out | grep ': /tools'