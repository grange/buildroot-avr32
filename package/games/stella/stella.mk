#############################################################
#
# stella
#
#############################################################
STELLA_VERSION = 2.7.3a
STELLA_SOURCE = stella-$(STELLA_VERSION)-src.tar.gz
STELLA_SITE = http://superb-west.dl.sourceforge.net/sourceforge/stella
STELLA_AUTORECONF = NO
STELLA_INSTALL_STAGING = NO
STELLA_INSTALL_TARGET = YES

STELLA_CONF_OPT = --with-zlib-prefix=$(STAGING_DIR)/usr --with-zlib-prefix=$(STAGING_DIR)/usr \
					--prefix=/usr --bindir=/usr/bin --docdir=/usr/share/doc/stella --datadir=/usr/share \
					LDFLAGS="-lstdc++ -lc"
					

STELLA_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

STELLA_DEPENDENCIES = uclibc zlib sdl

$(eval $(call AUTOTARGETS,package/games,stella))

