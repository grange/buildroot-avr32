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

LYNX_CONF_OPT = --with-ssl --enable-scrollbar
LYNX_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

LYNX_DEPENDENCIES = uclibc ncurses openssl

$(eval $(call AUTOTARGETS,package,lynx))

