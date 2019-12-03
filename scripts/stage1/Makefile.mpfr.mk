include env.mk

GCC_DIR         ?= .
MPFR_NAME       =   mpfr
MPFR_VERSION    =   4.0.2
MPFR_DIR        =   $(GCC_DIR)/$(MPFR_NAME)
MPFR_ARCHIVE    =   $(MPFR_NAME)-$(MPFR_VERSION).tar.gz
MPFR_URL        =   https://www.mpfr.org/mpfr-current/$(MPFR_ARCHIVE)
MPFR_SRC_FILE   =   $(DL_DIR)/$(MPFR_ARCHIVE)      


mpfr: $(MPFR_DIR)

$(MPFR_DIR): $(MPFR_SRC_FILE)
	echo "Extract files $(MPFR_SRC_FILE) ..."
	cd $(GCC_DIR) && \
	tar -xzvf $(MPFR_SRC_FILE)  > /dev/null && \
	ln -s $(MPFR_NAME)-$(MPFR_VERSION) $(MPFR_DIR)

$(MPFR_SRC_FILE):
	wget --continue --directory-prefix=$(DL_DIR) $(MPFR_URL)


