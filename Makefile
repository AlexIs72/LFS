include env.mk

DIRS	= $(TOOLCHAIN_DIR) $(ROOTFS_DIR) $(LOG_DIR) $(SRC_DIR) $(DL_DIR) $(BUILD_DIR)
STAGE1 	= binutils_pass1 gcc_pass1 kernel_headers glibc libstdc++ binutils_pass2 gcc_pass2 
STAGE1  += tcl expect dejagnu bash bison bzip2 coreutils diffutils file findutils gawk
STAGE1  += gettext grep gzip m4 make ncurses patch perl python sed tar texinfo xz

#GCC-9.2.0 - Pass 1
#Linux-5.2.8 API Headers
#Glibc-2.30
#Libstdc++ from GCC-9.2.0
#Binutils-2.32 - Pass 2
#GCC-9.2.0 - Pass 2
#Tcl-8.6.9
#Expect-5.45.4
#DejaGNU-1.6.2
#M4-1.4.18
#Ncurses-6.1
#Bash-5.0
#Bison-3.4.1
#Bzip2-1.0.8
#Coreutils-8.31
#Diffutils-3.7
#File-5.37
#Findutils-4.6.0
#Gawk-5.0.1
#Gettext-0.20.1
#Grep-3.3
#Gzip-1.10
#Make-4.2.1
#Patch-2.7.6
#Perl-5.30.0
#Python-3.7.4
#Sed-4.7
#Tar-1.32
#Texinfo-6.6
#Xz-5.2.4

export PATH=/$(TOOLCHAIN_DIR_NAME)/bin:/bin:/usr/bin

all: $(DIRS) fake_root $(STAGE1) stripping

$(STAGE1):
	make -f scripts/stage1/Makefile.$@.mk 2>&1 | tee $(LOG_DIR)/$@.build.log; \
	test $${PIPESTATUS[0]} = 0
#	[ $${PIPESTATUS[0]} -eq 0 ] || exit 1

stripping:
	strip --strip-debug /$(TOOLCHAIN_DIR_NAME)/lib/* || true
	/usr/bin/strip --strip-unneeded /$(TOOLCHAIN_DIR_NAME)/{,s}bin/* || true
	rm -rf /$(TOOLCHAIN_DIR_NAME)/{,share}/{info,man,doc}
	find /$(TOOLCHAIN_DIR_NAME)/{lib,libexec} -name \*.la -delete

fake_root:
	[ -d /$(TOOLCHAIN_DIR_NAME) ] || (echo "No build root - /$(TOOLCHAIN_DIR_NAME)!"; exit 1)

$(DIRS):
	mkdir -p $@


