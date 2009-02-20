#############################################################
#
# cellwriter
#
#############################################################
CELLWRITER_VERSION = 1.3.4
CELLWRITER_SOURCE = cellwriter-$(CELLWRITER_VERSION).tar.gz
CELLWRITER_SITE = http://pub.risujin.org/cellwriter
CELLWRITER_AUTORECONF = NO
CELLWRITER_INSTALL_STAGING = NO
CELLWRITER_INSTALL_TARGET = YES

CELLWRITER_CONF_OPT = 

CELLWRITER_DEPENDENCIES = uclibc libgtk2

$(eval $(call AUTOTARGETS,package,cellwriter))

