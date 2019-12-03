PKG_FULL_NAME   =   $(PKG_NAME)-$(PKG_VERSION)
PKG_ARCHIVE     =   $(PKG_FULL_NAME).tar.gz
PKG_URL         =   https://ftp.gnu.org/gnu/$(PKG_NAME)/$(PKG_FULL_NAME)/$(PKG_ARCHIVE)
#                    https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/

PKG_DIR         =   $(BUILD_DIR)/$(PKG_FULL_NAME)
PKG_SRC_DIR     =   $(SRC_DIR)/$(PKG_FULL_NAME)
PKG_SRC_FILE    =   $(DL_DIR)/$(PKG_ARCHIVE)    
PKG_PASS_DIR    =   $(PKG_DIR)_$(PKG_SUFFIX)
PKG_BUILD_DIR   =   $(PKG_DIR)
#/.build

DONE_MARKER_FILE =  $(call get_done_marker_file_name,$(PKG_NAME),$(PKG_VERSION))

CONFIGURE       =   $(PKG_SRC_DIR)/configure --prefix=/$(TOOLCHAIN_DIR_NAME)
