#############################################################
#
# webkit
#
#############################################################

WEBKIT_VERSION = r40813
WEBKIT_SOURCE = WebKit-$(WEBKIT_VERSION).tar.bz2
WEBKIT_SITE = http://builds.nightly.webkit.org/files/trunk/src
WEBKIT_DIR:=$(BUILD_DIR)/WebKit-$(WEBKIT_VERSION)

$(DL_DIR)/$(WEBKIT_SOURCE):
	 $(call DOWNLOAD,$(WEBKIT_SITE),$(WEBKIT_SOURCE))

webkit-source: $(DL_DIR)/$(WEBKIT_SOURCE)

$(WEBKIT_DIR)/.unpacked: $(DL_DIR)/$(WEBKIT_SOURCE)
	$(BZCAT) $(DL_DIR)/$(WEBKIT_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	$(CONFIG_UPDATE) $(WEBKIT_DIR)
	toolchain/patch-kernel.sh $(WEBKIT_DIR) package/webkit/ \*.patch
	touch $@

$(WEBKIT_DIR)/.configured: $(WEBKIT_DIR)/.unpacked
	(cd $(WEBKIT_DIR); ./autogen.sh; \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
	);
	touch $@

$(WEBKIT_DIR)/.done: $(WEBKIT_DIR)/.configured
	$(MAKE) -C $(WEBKIT_DIR) GLIB_GENMARSHAL=$(HOST_GLIB)/bin/glib-genmarshal \
		GLIB_MKENUMS=$(HOST_GLIB)/bin/glib-mkenums
	$(MAKE) -C $(WEBKIT_DIR) install DESTDIR=$(TARGET_DIR)
	touch $@

webkit: icu curl libxml2 libxslt libgtk2 sqlite $(WEBKIT_DIR)/.done

webkit-clean:
	rm -f $(TARGET_DIR)/bin/webkit
	-$(MAKE) -C $(WEBKIT_DIR) clean

webkit-dirclean:
	rm -rf $(WEBKIT_DIR)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_PACKAGE_WEBKIT),y)
TARGETS+=webkit
endif