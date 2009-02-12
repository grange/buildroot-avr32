#############################################################
#
# flite
#
#############################################################
FLITE_VERSION = 1.3
FLITE_SOURCE = flite-$(FLITE_VERSION)-release.tar.gz
FLITE_SITE = http://www.speech.cs.cmu.edu/flite/packed/flite-$(FLITE_VERSION)
FLITE_AUTORECONF = NO
FLITE_INSTALL_STAGING = NO
FLITE_INSTALL_TARGET = YES
FLITE_INSTALL_TARGET_OPT = INSTALLBINDIR=$(TARGET_DIR)/usr/bin \
							INSTALLLIBDIR=$(TARGET_DIR)/usr/share/festival/lib \
							INSTALLINCDIR=$(TARGET_DIR)/usr/include/flite \
							STRIP=$(TARGET_STRIP) install

FLITE_CONF_OPT = --prefix=/usr --libdir=/usr/share/festival/lib

FLITE_MAKE_OPT = CC=$(TARGET_CC) CXX=$(TARGET_CXX)

FLITE_DEPENDENCIES = uclibc alsa-lib speech-tools

$(eval $(call AUTOTARGETS,package/multimedia/festival,flite))

