#############################################################
#
# ampache
#
#############################################################

AMPACHE_VERSION = 3.4.4
AMPACHE_SOURCE = ampache-$(AMPACHE_VERSION).tar.gz
AMPACHE_SITE = http://ampache.org/downloads/
AMPACHE_DIR=$(BUILD_DIR)/ampache-$(AMPACHE_VERSION)

$(DL_DIR)/$(AMPACHE_SOURCE):
	 $(call DOWNLOAD,$(AMPACHE_SITE),$(AMPACHE_SOURCE))

ampache-source: $(DL_DIR)/$(AMPACHE_SOURCE)

$(AMPACHE_DIR)/.unpacked: $(DL_DIR)/$(AMPACHE_SOURCE)
	$(ZCAT) $(DL_DIR)/$(AMPACHE_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	touch $@

$(TARGET_DIR)/www/ampache: $(AMPACHE_DIR)/.unpacked
	mkdir -p $(TARGET_DIR)/www
	cp -a $(AMPACHE_DIR) $@

ampache: $(TARGET_DIR)/www/ampache

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_PACKAGE_AMPACHE),y)
TARGETS+=ampache
endif
