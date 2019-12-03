include env.mk

GCC_DIR			?= .
MPC_NAME		=	mpc
MPC_VERSION		= 	1.1.0
MPC_DIR         =   $(GCC_DIR)/$(MPC_NAME)
MPC_ARCHIVE     =   $(MPC_NAME)-$(MPC_VERSION).tar.gz
MPC_URL         =   https://ftp.gnu.org/gnu/mpc/$(MPC_ARCHIVE)
MPC_SRC_FILE    =   $(DL_DIR)/$(MPC_ARCHIVE)

mpc: $(MPC_DIR)

$(MPC_DIR): $(MPC_SRC_FILE)
	echo "Extract files $(MPC_SRC_FILE) ..."
	cd $(GCC_DIR) && \
	tar -xzvf $(MPC_SRC_FILE)  > /dev/null && \
	ln -s $(MPC_NAME)-$(MPC_VERSION) $(MPC_DIR)

$(MPC_SRC_FILE):
	wget --continue --directory-prefix=$(DL_DIR) $(MPC_URL)



