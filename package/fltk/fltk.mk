#############################################################
#
# fltk
#
#############################################################

FLTK_VERSION = 1.1.9
FLTK_SOURCE = fltk-$(FLTK_VERSION)-source.tar.bz2
FLTK_SITE = http://ftp.easysw.com/pub/fltk/$(FLTK_VERSION)/
FLTK_AUTORECONF = NO
FLTK_INSTALL_STAGING = YES
FLTK_INSTALL_TARGET = YES

FLTK_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) STRIP=$(TARGET_STRIP) install
FLTK_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) STRIP=$(TARGET_STRIP) install

ifeq ($(BR2_PACKAGE_DIRECTFB), y)
  SERVER_CONFIG=--enable-directfb --with-archflags="-I$(STAGING_DIR)/usr/include/directfb" --without-x
  SERVER_DEP=directfb
else
  SERVER_CONFIG=--with-x
  SERVER_DEP=$(XSERVER)
endif

FLTK_CONF_OPT = --target=$(GNU_TARGET_NAME) --host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) --prefix=/usr \
		--sysconfdir=/etc --enable-shared --enable-threads --disable-gl $(SERVER_CONFIG)

FLTK_DEPENDENCIES = uclibc $(SERVER_DEP)

$(eval $(call AUTOTARGETS,package,fltk))