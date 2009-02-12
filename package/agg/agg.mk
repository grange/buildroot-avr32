#############################################################
#
# agg
#
#############################################################
AGG_VERSION = 2.5
AGG_SOURCE = agg-$(AGG_VERSION).tar.gz
AGG_SITE = http://www.antigrain.com
AGG_AUTORECONF = YES
AGG_INSTALL_STAGING = YES
AGG_INSTALL_TARGET = YES

AGG_CONF_OPT = --with-sdl-prefix=$(STAGING_DIR)/usr
AGG_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

AGG_DEPENDENCIES = uclibc sdl

$(eval $(call AUTOTARGETS,package,agg))

$(AGG_DIR)/.stamp_autoconfigured:
	cd $(AGG_DIR) && chmod +x autogen.sh && ./autogen.sh 
	touch $(AGG_DIR)/.stamp_autoconfigured
