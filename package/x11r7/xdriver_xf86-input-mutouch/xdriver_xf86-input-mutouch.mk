################################################################################
#
# xdriver_xf86-input-mutouch -- Microtouch input driver
#
################################################################################

XDRIVER_XF86_INPUT_MUTOUCH_VERSION = 1.2.0
XDRIVER_XF86_INPUT_MUTOUCH_SOURCE = xf86-input-mutouch-$(XDRIVER_XF86_INPUT_MUTOUCH_VERSION).tar.bz2
XDRIVER_XF86_INPUT_MUTOUCH_SITE = http://xorg.freedesktop.org/releases/individual/driver
XDRIVER_XF86_INPUT_MUTOUCH_AUTORECONF = NO
XDRIVER_XF86_INPUT_MUTOUCH_DEPENDENCIES = xserver_xorg-server xproto_inputproto xproto_randrproto xproto_xproto
XDRIVER_XF86_INPUT_MUTOUCH_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install

$(eval $(call AUTOTARGETS,package/x11r7,xdriver_xf86-input-mutouch))
