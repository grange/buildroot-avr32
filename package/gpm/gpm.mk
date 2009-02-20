#############################################################
#
# gpm
#
#############################################################
GPM_VERSION = 1.99.7
GPM_SOURCE = gpm-$(GPM_VERSION).tar.gz
GPM_SITE = http://launchpad.net/gpm/main/$(GPM_VERSION)/+download
GPM_AUTORECONF = NO
GPM_INSTALL_STAGING = NO
GPM_INSTALL_TARGET = YES

GPM_CONF_OPT = 

GPM_DEPENDENCIES = uclibc 

$(eval $(call AUTOTARGETS,package,gpm))

