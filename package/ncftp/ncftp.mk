#############################################################
#
# ncftp client
#
#############################################################
NCFTP_VERSION:=3.2.2
NCFTP_SOURCE:=ncftp-$(NCFTP_VERSION)-src.tar.bz2
NCFTP_SITE:=ftp://ftp.ncftp.com/ncftp
NCFTP_DIR:=$(BUILD_DIR)/ncftp-$(NCFTP_VERSION)

NCFTP_TARGET_BINS:=ncftp

ifeq ($(BR2_PACKAGE_NCFTP_GET),y)
NCFTP_TARGET_BINS+=ncftpget
endif

ifeq ($(BR2_PACKAGE_NCFTP_PUT),y)
NCFTP_TARGET_BINS+=ncftpput
endif

ifeq ($(BR2_PACKAGE_NCFTP_LS),y)
NCFTP_TARGET_BINS+=ncftpls
endif

ifeq ($(BR2_PACKAGE_NCFTP_BATCH),y)
NCFTP_TARGET_BINS+=ncftpbatch
endif

ifeq ($(BR2_PACKAGE_NCURSES),y)
ifeq ($(BR2_PACKAGE_NCFTP_SPOOLER),y)
#Someone needs to figure out what to do...
NCFTP_TARGET_BINS+=
endif

# only set if NCURSES is available
ifeq ($(BR2_PACKAGE_NCFTP_BOOKMARKS),y)
NCFTP_TARGET_BINS+=ncftpbookmarks
endif

NCFTP_DEPS += ncurses
endif

ncftp-source: $(DL_DIR)/$(NCFTP_SOURCE)

$(DL_DIR)/$(NCFTP_SOURCE):
	$(call DOWNLOAD,$(NCFTP_SITE),$(NCFTP_SOURCE))

$(NCFTP_DIR)/.source: $(DL_DIR)/$(NCFTP_SOURCE)
	$(BZCAT) $(DL_DIR)/$(NCFTP_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	touch $@

$(NCFTP_DIR)/.configured: $(NCFTP_DIR)/.source
	(cd $(NCFTP_DIR); rm -f config.cache; \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--sysconfdir=/etc \
	)
	touch $@

$(NCFTP_DIR)/bin/%: $(NCFTP_DIR)/.configured
	$(MAKE) -C $(NCFTP_DIR)

$(TARGET_DIR)/usr/bin/ncftp $(TARGET_DIR)/usr/bin/ncftp%: $(addprefix $(NCFTP_DIR)/bin/, $(NCFTP_TARGET_BINS))
	$(INSTALL) -m 0755 $(NCFTP_DIR)/bin/$(notdir $@) $(TARGET_DIR)/usr/bin
	$(STRIPCMD) $(STRIP_STRIP_ALL) $@

ncftp: uclibc $(NCFTP_DEPS) $(addprefix $(TARGET_DIR)/usr/bin/, $(NCFTP_TARGET_BINS))

ncftp-clean:
	-$(MAKE) -C $(NCFTP_DIR) clean
	rm -rf $(addprefix $(TARGET_DIR)/usr/bin/, $(NCFTP_TARGET_BINS))

ncftp-dirclean:
	rm -rf $(NCFTP_DIR)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_PACKAGE_NCFTP),y)
TARGETS+=ncftp
endif
