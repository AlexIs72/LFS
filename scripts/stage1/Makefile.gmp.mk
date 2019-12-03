include env.mk

GCC_DIR         ?= .
GMP_NAME        =   gmp
GMP_VERSION     =   6.1.2
GMP_DIR         =   $(GCC_DIR)/$(GMP_NAME)
GMP_ARCHIVE     =   $(GMP_NAME)-$(GMP_VERSION).tar.bz2
GMP_URL         =   https://ftp.gnu.org/gnu/gmp/$(GMP_ARCHIVE)
GMP_SRC_FILE    =   $(DL_DIR)/$(GMP_ARCHIVE) 

gmp: $(GMP_DIR)

$(GMP_DIR): $(GMP_SRC_FILE)
	echo "Extract files $(GMP_SRC_FILE) ..."
	cd $(GCC_DIR) && \
	tar -xjvf $(GMP_SRC_FILE)  > /dev/null && \
	ln -s $(GMP_NAME)-$(GMP_VERSION) $(GMP_DIR)

$(GMP_SRC_FILE):
	wget --continue --directory-prefix=$(DL_DIR) $(GMP_URL)
