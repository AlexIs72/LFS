include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

#SHELL           =   /bin/bash

PKG_NAME	    =	make
PKG_VERSION	    =	4.2.1
#PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
#PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.gz
#PKG_URL	    	=	https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_ARCHIVE)
#PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	
#PKG_BUILD_DIR   =   $(PKG_DIR)/.build

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION))   

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	cd $(PKG_BUILD_DIR) && \
	make -j $(NUM_CPU) && \
	make install
	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION))

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) $(PKG_URL) 

#$(PKG_DIR): $(PKG_SRC_FILE)
#	echo "Extract files $(PKG_SRC_FILE) ..."
#	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null

$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_SRC_DIR) && \
	sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) --without-guile

include scripts/build_rules.mk



