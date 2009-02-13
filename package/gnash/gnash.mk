#############################################################
#
# gnash
#
#############################################################
GNASH_VERSION = 0.8.3
GNASH_SOURCE = gnash-$(GNASH_VERSION).tar.bz2
GNASH_SITE = ftp://ftp.cise.ufl.edu/pub/mirrors/GNU/gnu/gnash/0.8.3
GNASH_AUTORECONF = NO
GNASH_INSTALL_STAGING = NO
GNASH_INSTALL_TARGET = YES

GNASH_CONF_ENV = ac_cv_type_error_t=no ac_cv_path_curlconfig=$(STAGING_DIR)/usr/bin/curl-config

ifeq ($(BR2_GNASH_GUI_GTK2),y)
	GNASH_GUI=--enable-gui=gtk
	GNASH_GUI_DEP=libgtk2
endif

ifeq ($(BR2_GNASH_GUI_FLTK),y)
	GNASH_GUI=--enable-gui=fltk
	GNASH_GUI_DEP=fltk
endif

ifeq ($(BR2_GNASH_GUI_NONE),y)
	GNASH_GUI=--disable-gui
	GNASH_GUI_DEP=
endif

# the hugest configure string ever... anyone ever heard of pkgconfig?
GNASH_CONF_OPT = --with-sdl-incl=$(STAGING_DIR)/usr/include --with-sdl-lib=$(STAGING_DIR)/usr/lib \
				--with-expat-incl=$(STAGING_DIR)/usr/include --with-expat-lib=$(STAGING_DIR)/usr/lib \
				--with-gstreamer-incl=$(STAGING_DIR)/usr/include/gstreamer-0.10 --with-gstreamer-lib=$(STAGING_DIR)/usr/lib \
				--with-agg-incl=$(STAGING_DIR)/usr/include/agg2 --with-agg-lib=$(STAGING_DIR)/usr/lib \
				--with-curl-incl=$(STAGING_DIR)/usr/include \
				--with-boost-incl=$(STAGING_DIR)/usr/include --with-boost-lib=$(STAGING_DIR)/usr/lib \
				--with-freetype-incl=$(STAGING_DIR)/usr/include/freetype2 --with-freetype-lib=$(STAGING_DIR)/usr/lib \
				--with-fontconfig-incl=$(STAGING_DIR)/usr/include --with-fontconfig-lib=$(STAGING_DIR)/usr/lib \
				--with-z-incl=$(STAGING_DIR)/usr/include --with-z-lib=$(STAGING_DIR)/usr/lib \
				--with-x11-incl=$(STAGING_DIR)/usr/include --with-x11-lib=$(STAGING_DIR)/usr/lib \
				--with-atk-incl=$(STAGING_DIR)/usr/include/atk-1.0 --with-atk-lib=$(STAGING_DIR)/usr/lib \
				--with-jpeg-incl=$(STAGING_DIR)/usr/include --with-jpeg-lib=$(STAGING_DIR)/usr/lib \
				--with-glib-incl=$(STAGING_DIR)/usr/include/glib-2.0 --with-glib-lib=$(STAGING_DIR)/usr/lib \
				--with-gtk2-incl=$(STAGING_DIR)/usr/include/gtk-2.0 --enable-gui=gtk \
				--with-pango-incl=$(STAGING_DIR)/usr/include/pango-1.0 --with-pango-lib=$(STAGING_DIR)/usr/lib \
				--with-cairo-incl=$(STAGING_DIR)/usr/include/cairo --with-cairo-lib=$(STAGING_DIR)/usr/lib \
				--with-png-incl=$(STAGING_DIR)/usr/include --with-png-lib=$(STAGING_DIR)/usr/lib \
				--with-x11-incl=$(STAGING_DIR)/usr/include --with-x11-lib=$(STAGING_DIR)/usr/lib \
				--with-libxml-incl=$(STAGING_DIR)/usr/include/libxml2 --with-libxml-lib=$(STAGING_DIR)/usr/lib \
				--with-top-level=$(STAGING_DIR) --with-soldir=$(STAGING_DIR)/usr/lib CFLAGS="-D__error_t_defined=1 -D_INTL_REDIRECT_MACROS=1" \
				CXXFLAGS="-D__error_t_defined=1 -D_INTL_REDIRECT_MACROS=1" --with-plugindir=/usr/lib/mozilla/plugins \
				--disable-kparts $(GNASH_GUI) --enable-media=none --disable-testsuite --disable-cygnal --libdir=/usr/lib

# don't ask me what is going on with error.h/error_t and _INTL_REDIRECT_MACROS
# the gnash configure script is pretty lame.

GNASH_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

GNASH_DEPENDENCIES = uclibc boost agg $(GNASH_GUI_DEP) gstreamer

$(eval $(call AUTOTARGETS,package,gnash))

