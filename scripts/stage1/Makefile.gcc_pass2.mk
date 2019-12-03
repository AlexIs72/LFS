include env.mk
include scripts/macros.mk
include scripts/stage1/gcc_vars.mk

PKG_SUFFIX      =   pass2
#PKG_DIR         =   $(SRC_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)
#PKG_BUILD_DIR   =   $(BUILD_DIR)/$(PKG_FULL_NAME)_$(PKG_SUFFIX)

CC              =   $(LFS_TARGET)-gcc
CXX             =   $(LFS_TARGET)-g++
AR              =   $(LFS_TARGET)-ar
RANLIB          =   $(LFS_TARGET)-ranlib

FILE_NAME       =   $(shell $(LFS_TARGET)-gcc -print-libgcc-file-name)
INC_PATH        =   $(shell dirname $(FILE_NAME))

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION)_pass2)   

all: $(DONE_MARKER_FILE)

#$(DONE_MARKER_FILE):  $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && make -j $(NUM_CPU) && make install
#	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION)_pass2)

#$(PKG_DIR): $(PKG_SRC_FILE) $(MPFR_SRC_FILE) $(GMP_SRC_FILE) $(MPC_SRC_FILE)
#	echo "Extract files $(PKG_SRC_FILE) ..."
#	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null
#	mv $(PKG_SRC_DIR) $(PKG_DIR)
#	make -f scripts/stage1/Makefile.mpfr.mk GCC_DIR=$(PKG_DIR)
#	make -f scripts/stage1/Makefile.gmp.mk GCC_DIR=$(PKG_DIR)
#	make -f scripts/stage1/Makefile.mpc.mk GCC_DIR=$(PKG_DIR)

#$(PKG_SRC_DIR)::

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR) 
#	scripts/stage1/bin/fix_gcc_includes.sh $(PKG_PASS_DIR) $(TOOLCHAIN_DIR_NAME)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure                                       \
	    --prefix=/$(TOOLCHAIN_DIR_NAME)                                \
	    --with-local-prefix=/$(TOOLCHAIN_DIR_NAME)                     \
	    --with-native-system-header-dir=/$(TOOLCHAIN_DIR_NAME)/include \
	    --enable-languages=c,c++                       \
	    --disable-libstdcxx-pch                        \
	    --disable-multilib                             \
	    --disable-bootstrap                            \
	    --disable-libgomp

include scripts/build_rules.mk
include scripts/stage1/gcc_targets.mk

$(PKG_SRC_DIR):: 
	[ ! -d $(PKG_SRC_DIR) ] && { mv $(PKG_DIR) $(PKG_SRC_DIR); \
	cd $(PKG_SRC_DIR) && \
	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	$(INC_PATH)/include-fixed/limits.h; \
	scripts/stage1/bin/fix_gcc_includes.sh $(PKG_SRC_DIR) $(TOOLCHAIN_DIR_NAME); \
	make -f scripts/stage1/Makefile.mpfr.mk GCC_DIR=$(PKG_SRC_DIR); \
	make -f scripts/stage1/Makefile.gmp.mk GCC_DIR=$(PKG_SRC_DIR); \
	make -f scripts/stage1/Makefile.mpc.mk GCC_DIR=$(PKG_SRC_DIR); \
	} || true
