include env.mk
include scripts/macros.mk
include scripts/common_vars.mk

PKG_NAME	    =	tcl
PKG_MAJOR_VERSION = 8.6
PKG_VERSION	    =	$(PKG_MAJOR_VERSION).10
PKG_FULL_NAME   =   $(PKG_NAME)$(PKG_VERSION)
PKG_ARCHIVE     =   $(PKG_FULL_NAME)-src.tar.gz
PKG_URL	    	=	https://sourceforge.net/projects/tcl/files/Tcl/$(PKG_VERSION)/$(PKG_ARCHIVE)/download
#https://downloads.sourceforge.net//$(PKG_NAME)/$(PKG_ARCHIVE)
#PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
#PKG_BUILD_DIR   =   $(PKG_DIR)
#PKG_SRC_FILE	=   $(DL_DIR)/$(PKG_ARCHIVE)	

#DONE_MARKER_FILE :=  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION))   

#export LD_FLAGS = -L /$(TOOLCHAIN_DIR_NAME)/lib

all: $(DONE_MARKER_FILE)

$(DONE_MARKER_FILE): $(PKG_BUILD_DIR)/Makefile
	cd $(PKG_BUILD_DIR) && make -j $(NUM_CPU) 
	cd $(PKG_BUILD_DIR) && make install
	chmod -v u+w /$(TOOLCHAIN_DIR_NAME)/lib/libtcl$(PKG_MAJOR_VERSION).so
	cd $(PKG_BUILD_DIR) && make install-private-headers
	cd /$(TOOLCHAIN_DIR_NAME)/bin && ln -sv tclsh$(PKG_MAJOR_VERSION) /$(TOOLCHAIN_DIR_NAME)/bin/tclsh || true    
	$(call touch_done_marker_file,$(PKG_NAME),$(PKG_VERSION))

#$(PKG_SRC_FILE):
#	wget --continue --directory-prefix=$(DL_DIR) -O $(PKG_SRC_FILE) $(PKG_URL) 

$(PKG_DIR): $(PKG_SRC_FILE)
	echo "Extract files $(PKG_SRC_FILE) ..."
	cd $(BUILD_DIR) && tar -xzvf $(PKG_SRC_FILE)  > /dev/null
	touch $(PKG_DIR)


$(PKG_BUILD_DIR)/Makefile: $(PKG_SRC_DIR)
	mkdir -p $(PKG_BUILD_DIR) && \
	cd $(PKG_BUILD_DIR) && \
	$(PKG_SRC_DIR)/unix/configure \
	    --prefix=/$(TOOLCHAIN_DIR_NAME) 

include scripts/build_rules.mk



