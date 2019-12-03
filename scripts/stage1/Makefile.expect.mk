include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

#SHELL           =   /bin/bash

PKG_NAME	    =	expect
PKG_MAJOR_VERSION = 5.45
PKG_VERSION	    =	$(PKG_MAJOR_VERSION).4
PKG_FULL_NAME   =   $(PKG_NAME)$(PKG_VERSION)
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.gz
PKG_URL	    	=	https://sourceforge.net/projects/expect/files/Expect/$(PKG_VERSION)/$(PKG_ARCHIVE)/download
#https://downloads.sourceforge.net//$(PKG_NAME)/$(PKG_ARCHIVE)
#https://sourceforge.net/projects/expect/files/Expect/5.45.4/expect5.45.4.tar.gz/download

#PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_BUILD_DIR   =   $(PKG_DIR)/.build
#PKG_BUILD_DIR   =   $(PKG_DIR)/unix
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION))   

#export LDFLAGS= -L/$(TOOLCHAIN_DIR_NAME)/lib

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
#	cd $(PKG_BUILD_DIR) && 
	which gcc
	make -C $(PKG_BUILD_DIR) -j $(NUM_CPU) && \
	make -C $(PKG_BUILD_DIR) SCRIPTS="" install
	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION))

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) -O $(PKG_SRC_FILE) $(PKG_URL) 

#$(PKG_DIR): $(PKG_SRC_FILE)
#	echo "Extract files $(PKG_SRC_FILE) ..."
#	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null


$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	cd $(PKG_SRC_DIR) && \
	cp -v configure{,.orig} && \
	sed 's:/usr/local/bin:/bin:' configure.orig > configure && \
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) --target=$(LFS_TARGET) \
	    --with-tcl=/$(TOOLCHAIN_DIR_NAME)/lib \
	    --with-tclinclude=/$(TOOLCHAIN_DIR_NAME)/include
#	touch $(PKG_DIR)/Makefile

include scripts/build_rules.mk



