#############################################################
#
# lynx
#
#############################################################
LYNX_VERSION = 2.8.6
LYNX_SOURCE = lynx$(LYNX_VERSION).tar.bz2
LYNX_SITE = http://lynx.isc.org/lynx2.8.6
LYNX_AUTORECONF = NO
LYNX_INSTALL_STAGING = NO
LYNX_INSTALL_TARGET = YES

ifeq ($(BR2_PACKAGE_OPENSSL),y)
	LYNX_SSL_DEPS:=openssl ca-certificates
	LYNX_USE_SSL:=--with-ssl
endif

LYNX_CONF_OPT = $(LYNX_USE_SSL)
LYNX_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

LYNX_DEPENDENCIES = uclibc ncurses $(LYNX_SSL_DEPS)

$(eval $(call AUTOTARGETS,package,lynx))

