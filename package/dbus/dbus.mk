#############################################################
#
# dbus
#
#############################################################
DBUS_VERSION = 1.1.1
DBUS_SOURCE = dbus-$(DBUS_VERSION).tar.gz
DBUS_SITE = http://dbus.freedesktop.org/releases/dbus
DBUS_AUTORECONF = YES
DBUS_INSTALL_STAGING = YES
DBUS_INSTALL_TARGET = YES
DBUS_EXTRA_FILES = /etc/init.d/S30dbus

ifeq ($(strip $(BR2_DBUS_EXPAT)),y)
DBUS_XML:=expat
DBUS_XML_DEP:=expat
else
DBUS_XML:=libxml
DBUS_XML_DEP:=libxml2
endif

DBUS_CONF_ENV = ac_cv_have_abstract_sockets=yes \
				ac_cv_func_posix_getpwnam_r=yes \
				have_abstract_sockets=yes 

DBUS_CONF_OPT = --target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--exec-prefix=/usr \
		--localstatedir=/var \
		--program-prefix="" \
		--sysconfdir=/etc \
		--with-dbus-user=dbus \
		--disable-tests \
		--disable-asserts \
		--enable-abstract-sockets \
		--disable-selinux \
		--disable-xml-docs \
		--disable-doxygen-docs \
		--disable-static \
		--enable-dnotify \
		--without-x \
		--with-xml=$(DBUS_XML) \
		--with-system-socket=/var/run/dbus/system_bus_socket \
		--with-system-pid-file=/var/run/messagebus.pid 

DBUS_DEPENDENCIES = uclibc $(DBUS_XML_DEP) pkgconfig

$(eval $(call AUTOTARGETS,package,dbus))

