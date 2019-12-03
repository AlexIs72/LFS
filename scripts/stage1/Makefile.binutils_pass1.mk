include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	binutils
PKG_VERSION	    =	2.33.1
PKG_SUFFIX      =   pass1
#PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.gz
#PKG_URL	    	=	https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_ARCHIVE)
#PKG_SRC_DIR     =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_DIR         =   $(PKG_SRC_DIR)_pass1
#PKG_BUILD_DIR   =   $(PKG_DIR)/.build_$(PKG_SUFFIX)
PKG_BUILD_DIR   =   $(PKG_DIR)_$(PKG_SUFFIX)
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION)_$(PKG_SUFFIX))   

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && 
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) 
	case $(shell uname -m) in \
	    x86_64) [ ! -d /$(TOOLCHAIN_DIR_NAME)/lib ] && (mkdir -v /$(TOOLCHAIN_DIR_NAME)/lib && ln -sv lib /$(TOOLCHAIN_DIR_NAME)/lib64) || true ;; \
	esac
#	cd $(PKG_BUILD_DIR) && 
	make -C $(PKG_BUILD_DIR) install
	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION)_$(PKG_SUFFIX))

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) $(PKG_URL)

#$(PKG_DIR): $(PKG_SRC_FILE)
#	echo $(suffix $(PKG_SRC_FILE))    
#	echo "Extract files $(PKG_SRC_FILE) ..."
#	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null
#	mv $(PKG_SRC_DIR) $(PKG_DIR)

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure $(MULTILIBOPT) \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) \
	    --with-sysroot=$(LFS) \
	    --target=$(LFS_TARGET) --disable-nls --disable-werror

#	    --with-lib-path=$(TOOLCHAIN_DIR)/lib \

include scripts/build_rules.mk



