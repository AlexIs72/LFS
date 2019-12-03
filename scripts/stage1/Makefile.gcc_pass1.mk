include env.mk
include scripts/macros.mk
include scripts/stage1/gcc_vars.mk

PKG_SUFFIX      =   pass1
#PKG_DIR         =   $(SRC_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)


#PKG_BUILD_DIR   =   $(PKG_DIR)_$(PKG_SUFFIX)

#PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_PASS_DIR    =   $(PKG_DIR)_$(PKG_SUFFIX)
#PKG_BUILD_DIR   =   $(PKG_PASS_DIR)/.build
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION)_$(PKG_SUFFIX))   

all: $(DONE_MARKER_FILE)

#$(DONE_MARKER_FILE):  $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && make -j $(NUM_CPU) && make install
#	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION)_$(PKG_SUFFIX))

##$(PKG_DIR): $(PKG_SRC_FILE) 
#$(PKG_PASS_DIR): $(PKG_DIR) $(MPFR_SRC_FILE) $(GMP_SRC_FILE) $(MPC_SRC_FILE)
##	echo "Extract files $(PKG_SRC_FILE) ..."
##	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null
#	mv $(PKG_DIR) $(PKG_PASS_DIR)    
#	make -f scripts/stage1/Makefile.mpfr.mk GCC_DIR=$(PKG_PASS_DIR)
#	make -f scripts/stage1/Makefile.gmp.mk GCC_DIR=$(PKG_PASS_DIR)
#	make -f scripts/stage1/Makefile.mpc.mk GCC_DIR=$(PKG_PASS_DIR)


$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR) 
#	scripts/stage1/bin/fix_gcc_includes.sh $(PKG_SRC_DIR) $(TOOLCHAIN_DIR_NAME)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure                        \
	    --target=$(LFS_TARGET)                       \
	    --prefix=/$(TOOLCHAIN_DIR_NAME)               \
	    --with-glibc-version=2.4                      \
	    --with-sysroot=$(LFS)                          \
	    --with-newlib                                  \
	    --without-headers                              \
	    --with-local-prefix=/$(TOOLCHAIN_DIR_NAME)     \
	    --with-native-system-header-dir=/$(TOOLCHAIN_DIR_NAME)/include \
	    --disable-nls                                  \
	    --disable-shared                               \
	    --disable-multilib                             \
	    --disable-decimal-float                        \
	    --disable-threads                              \
	    --disable-libatomic                            \
	    --disable-libgomp                              \
	    --disable-libmpx                               \
	    --disable-libquadmath                          \
	    --disable-libssp                               \
	    --disable-libvtv                               \
	    --disable-libstdcxx                            \
	    --disable-lto                                  \
	    --enable-languages=c,c++


include scripts/build_rules.mk
include scripts/stage1/gcc_targets.mk

$(PKG_SRC_DIR)::
	[ ! -d $(PKG_SRC_DIR) ] && { mv $(PKG_DIR) $(PKG_SRC_DIR); \
	scripts/stage1/bin/fix_gcc_includes.sh $(PKG_SRC_DIR) $(TOOLCHAIN_DIR_NAME); \
	make -f scripts/stage1/Makefile.mpfr.mk GCC_DIR=$(PKG_SRC_DIR); \
	make -f scripts/stage1/Makefile.gmp.mk GCC_DIR=$(PKG_SRC_DIR); \
	make -f scripts/stage1/Makefile.mpc.mk GCC_DIR=$(PKG_SRC_DIR); \
	} || true


