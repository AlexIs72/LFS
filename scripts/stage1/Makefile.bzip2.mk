include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

#SHELL           =   /bin/bash

PKG_NAME	    =	bzip2
PKG_VERSION	    =	1.0.8
#PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.gz
PKG_URL	    	=	https://www.sourceware.org/pub/$(PKG_NAME)/$(PKG_ARCHIVE)
#https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_ARCHIVE)
#PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	
#PKG_BUILD_DIR   =   $(PKG_DIR)/.build

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION))   

#all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_DIR)
	make -C $(PKG_DIR) PREFIX=/$(TOOLCHAIN_DIR_NAME) install

#$(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && \
#	make -j $(NUM_CPU) && \
#	make install
#	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION))

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) $(PKG_URL) 

$(PKG_DIR): $(PKG_SRC_FILE)
	echo "Extract files $(PKG_SRC_FILE) ..."
	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null

#$(PKG_BUILD_DIR)/Makefile: $(PKG_DIR)
#	make PREFIX=/$(TOOLCHAIN_DIR_NAME) install


#	mkdir -p $(PKG_BUILD_DIR) && \
#	cd $(PKG_BUILD_DIR) && \
#	../configure \
#	    --prefix=/$(TOOLCHAIN_DIR_NAME)

include scripts/build_rules.mk



