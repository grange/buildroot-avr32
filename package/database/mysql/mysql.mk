#############################################################
#
# MySQL 5.1
#
#############################################################
MYSQL_VERSION = 5.1.30
MYSQL_SOURCE = mysql-$(MYSQL_VERSION).tar.gz
MYSQL_SITE = http://mirrors.24-7-solutions.net/pub/mysql/Downloads/MySQL-5.1
MYSQL_INSTALL_TARGET = YES
MYSQL_INSTALL_STAGING = YES
MYSQL_DEPENDENCIES = uclibc readline

ifneq ($(BR2_PACKAGE_MYSQL_SERVER),y)
	MYSQL_DISABLE_SERVER=--without-server
endif

MYSQL_CONF_ENV = ac_cv_sys_restartable_syscalls=yes ac_cv_c_stack_direction=0
MYSQL_CONF_OPT = \
	--target=$(GNU_TARGET_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--program-prefix="" \
	--prefix=/usr \
	--without-ndb-binlog \
	--without-docs \
	--without-man \
	--without-libedit \
	--with-low-memory \
	--enable-thread-safe-client \
	$(MYSQL_DISABLE_SERVER) \
	$(ENABLE_DEBUG)

$(eval $(call AUTOTARGETS,package/database,mysql))
