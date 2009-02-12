#############################################################
#
# stella
#
#############################################################
STELLA_VERSION = 2.7.3a
STELLA_SOURCE = stella-$(STELLA_VERSION).tar.gz
STELLA_SITE = http://superb-west.dl.sourceforge.net/sourceforge/stella
STELLA_AUTORECONF = NO
STELLA_INSTALL_STAGING = NO
STELLA_INSTALL_TARGET = YES

STELLA_CONF_OPT = 

STELLA_DEPENDENCIES = uclibc 

$(eval $(call AUTOTARGETS,package,stella))

