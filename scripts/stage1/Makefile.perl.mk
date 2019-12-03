include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

#SHELL           =   /bin/bash

PKG_NAME	    =	perl
PKG_VERSION	    =	5.30.0
#PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.xz
PKG_URL	    	=	https://www.cpan.org/src/5.0/$(PKG_ARCHIVE)
PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	
#PKG_BUILD_DIR   =   $(PKG_DIR)/.build

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION))   

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_DIR)/Makefile.SH
	cd $(PKG_DIR) && \
	make -j $(NUM_CPU) && \
	cp -v perl cpan/podlators/scripts/pod2man /$(TOOLCHAIN_DIR_NAME)/bin && \
	mkdir -pv /$(TOOLCHAIN_DIR_NAME)/lib/perl5/$(PKG_VERSION) && \
	cp -Rv lib/* /$(TOOLCHAIN_DIR_NAME)/lib/perl5/$(PKG_VERSION) && \
	chmod -R u+rw /$(TOOLCHAIN_DIR_NAME)/lib/perl5/$(PKG_VERSION)/*
	touch $(PKG_DIR)/Makefile.SH    
#	make install
	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION))

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) $(PKG_URL) 

$(PKG_DIR): $(PKG_SRC_FILE)
	echo "Extract files $(PKG_SRC_FILE) ..."
	cd $(BUILD_DIR) && tar -xJvf $(PKG_SRC_FILE)  > /dev/null

$(PKG_DIR)/Makefile.SH: $(PKG_DIR)
#	mkdir -p $(PKG_BUILD_DIR) && 
	cd $(PKG_DIR) && \
	sh Configure -des -Dprefix=/$(TOOLCHAIN_DIR_NAME) -Dlibs=-lm -Uloclibpth -Ulocincpth

include scripts/build_rules.mk



