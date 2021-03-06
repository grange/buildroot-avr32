################################################################################
#
# xdriver_xf86-input-microtouch -- MicroTouch input driver
#
################################################################################

XDRIVER_XF86_INPUT_MICROTOUCH_VERSION = 1.2.0
XDRIVER_XF86_INPUT_MICROTOUCH_SOURCE = xf86-input-microtouch-$(XDRIVER_XF86_INPUT_MICROTOUCH_VERSION).tar.bz2
XDRIVER_XF86_INPUT_MICROTOUCH_SITE = http://xorg.freedesktop.org/releases/individual/driver
XDRIVER_XF86_INPUT_MICROTOUCH_AUTORECONF = NO
XDRIVER_XF86_INPUT_MICROTOUCH_DEPENDENCIES = xserver_xorg-server xproto_inputproto xproto_randrproto xproto_xproto
XDRIVER_XF86_INPUT_MICROTOUCH_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

$(eval $(call AUTOTARGETS,package/x11r7,xdriver_xf86-input-microtouch))
