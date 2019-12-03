SHELL               =   /bin/bash
LFS                 =   $(PWD)/.output
LFS_TARGET          =   x86_64-aaeon-linux-gnu
NUM_CPU             =   $(shell nproc --all)

TOOLCHAIN_DIR_NAME  =   tools
TOOLCHAIN_DIR       =   $(LFS)/$(TOOLCHAIN_DIR_NAME)
ROOTFS_DIR          =   $(LFS)/rootfs
LOG_DIR             =   $(LFS)/log
SRC_DIR             =   $(LFS)/src
DL_DIR              =   $(LFS)/dl
BUILD_DIR           =   $(LFS)/build
#TARGET = $(shell uname -m)

MULTILIB            = no
MULTILIBOPT         = "--with-lib-path=/$(TOOLCHAIN_DIR_NAME)/lib"

ifeq ($(MULTILIB), yes)
	MULTILIBOPT += ":$(TOOLCHAIN_DIR_NAME)/lib32"
endif
