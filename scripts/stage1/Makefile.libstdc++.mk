include env.mk
include scripts/macros.mk
include scripts/stage1/gcc_vars.mk

PKG_SUFFIX      =   lisbstdc++
#PKG_DIR         =   $(SRC_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
#PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)

#PKG_SRC_DIR     =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_DIR         =   $(PKG_SRC_DIR)_lisbstdc++
#PKG_BUILD_DIR   =   $(PKG_DIR)/.build
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,libstdc++,$(PKG_VERSION))   

all: $(DONE_MARKER_FILE)

#$(DONE_MARKER_FILE):  $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && make -j $(NUM_CPU) && make install
#	$(call touch_done_marker_file,libstdc++,$(PKG_VERSION))

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) $(PKG_URL)


$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR) 
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/libstdc++-v3/configure           \
	    --host=$(LFS_TARGET)                 \
	    --prefix=/$(TOOLCHAIN_DIR_NAME)                 \
	    --disable-multilib              \
	    --disable-nls                   \
	    --disable-libstdcxx-threads     \
	    --disable-libstdcxx-pch         \
	    --with-gxx-include-dir=/$(TOOLCHAIN_DIR_NAME)/$(LFS_TARGET)/include/c++/$(PKG_VERSION)


include scripts/build_rules.mk
include scripts/stage1/gcc_targets.mk

$(PKG_SRC_DIR)::
#	echo "Extract files $(PKG_SRC_FILE) ..."
#	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null
	[ ! -d $(PKG_SRC_DIR) ] && { mv $(PKG_DIR) $(PKG_SRC_DIR); \
	make -f scripts/stage1/Makefile.mpfr.mk GCC_DIR=$(PKG_SRC_DIR); \
	make -f scripts/stage1/Makefile.gmp.mk GCC_DIR=$(PKG_SRC_DIR); \
	make -f scripts/stage1/Makefile.mpc.mk GCC_DIR=$(PKG_SRC_DIR); \
	} || true

