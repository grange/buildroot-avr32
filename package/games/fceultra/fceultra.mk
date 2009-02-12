#############################################################
#
# fceultra
#
#############################################################
FCEULTRA_VERSION = 0.98.12
FCEULTRA_SOURCE = fceu-$(FCEULTRA_VERSION).src.tar.bz2
FCEULTRA_SITE = http://internap.dl.sourceforge.net/sourceforge/fceultra
FCEULTRA_AUTORECONF = NO
FCEULTRA_INSTALL_STAGING = NO
FCEULTRA_INSTALL_TARGET = YES
FCEULTRA_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

FCEULTRA_CONF_OPT = --program-prefix=""

FCEULTRA_DEPENDENCIES = uclibc sdl

$(eval $(call AUTOTARGETS,package,fceultra))

