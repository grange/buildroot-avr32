#############################################################
#
# midori
#
#############################################################

MIDORI_VERSION = 0.1.2
MIDORI_SOURCE = midori-$(MIDORI_VERSION).tar.bz2
MIDORI_SITE = http://goodies.xfce.org/releases/midori/
MIDORI_DIR:=$(BUILD_DIR)/midori-$(MIDORI_VERSION)

$(DL_DIR)/$(MIDORI_SOURCE):
	 $(call DOWNLOAD,$(MIDORI_SITE),$(MIDORI_SOURCE))

midori-source: $(DL_DIR)/$(MIDORI_SOURCE)

$(MIDORI_DIR)/.unpacked: $(DL_DIR)/$(MIDORI_SOURCE)
	$(BZCAT) $(DL_DIR)/$(MIDORI_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	$(CONFIG_UPDATE) $(MIDORI_DIR)
	toolchain/patch-kernel.sh $(MIDORI_DIR) package/midori/ \*.patch
	touch $@

$(MIDORI_DIR)/.configured: $(MIDORI_DIR)/.unpacked
	(cd $(MIDORI_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		LDFLAGS="-L$(STAGING_DIR)/usr/avr32-linux-uclibc/lib -lstdc++" CXXFLAGS="-mrelax" CFLAGS="-mrelax" \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--prefix=/usr \
		--enable-sqlite --enable-addons \
	);
	touch $@

$(MIDORI_DIR)/.cross_compile_fix: $(MIDORI_DIR)/.configured
	$(SED) "s,^GLIB_GENMARSHAL.*,GLIB_GENMARSHAL = '/usr/bin/glib-genmarshal',g" $(MIDORI_DIR)/_build_/c4che/default.cache.py
	$(SED) "s,^GLIB_MKENUMS.*,GLIB_MKENUMS = '/usr/bin/glib-mkenums',g" $(MIDORI_DIR)/_build_/c4che/default.cache.py
	$(SED) "s,^LIB_WEBKIT = \[,LIB_WEBKIT = \['stdc++'\, ,g" $(MIDORI_DIR)/_build_/c4che/default.cache.py
	touch $@

$(MIDORI_DIR)/.done: $(MIDORI_DIR)/.cross_compile_fix
	$(MAKE) -C $(MIDORI_DIR)
	$(MAKE) -C $(MIDORI_DIR) install DESTDIR=$(TARGET_DIR)
	touch $@

midori: uclibc webkit libsexy $(XSERVER) $(MIDORI_DIR)/.done

midori-clean:
	rm -f $(TARGET_DIR)/bin/midori
	-$(MAKE) -C $(MIDORI_DIR) clean

midori-dirclean:
	rm -rf $(MIDORI_DIR)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_PACKAGE_MIDORI),y)
TARGETS+=midori
endif