#############################################################
#
# boost
#
#############################################################
BOOST_VERSION = 1_35_0
BOOST_SOURCE = boost_$(BOOST_VERSION).tar.bz2
BOOST_SITE = http://voxel.dl.sourceforge.net/sourceforge/boost
BOOST_DIR =$(BUILD_DIR)/boost_$(BOOST_VERSION)

$(DL_DIR)/$(BOOST_SOURCE):
	 $(WGET) -P $(DL_DIR) $(BOOST_SITE)/$(BOOST_SOURCE)

$(BOOST_DIR)/.stamp_unpacked: $(DL_DIR)/$(BOOST_SOURCE)
	$(BZCAT) $(DL_DIR)/$(BOOST_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	toolchain/patch-kernel.sh $(BOOST_DIR) package/boost/ \*.patch
	$(CONFIG_UPDATE) $(BOOST_DIR)
	echo "using gcc : $(BR2_GCC_VERSION) : $(TARGET_CC)  ; " > $(BOOST_DIR)/tools/build/v2/user-config.jam
	touch $@

# bootstrap builds the stupid jam program and runs configure ...
# more on jam at http://www.perforce.com/jam/jam.html
$(BOOST_DIR)/.stamp_configured: $(BOOST_DIR)/.stamp_unpacked
	( cd $(BOOST_DIR) && \
		./configure \
		--prefix=/usr \
	)
	touch $@

# ... then we create symbolic links to the target toolchain
# and set ./ to the head of the path, to trick the incredibly 
# STUPID jam program into using the target tools.
$(BOOST_DIR)/.stamp_compiled: $(BOOST_DIR)/.stamp_configured
	( cd $(BOOST_DIR) && \
		ln -fs $(TARGET_CC) g++ && \
	    ln -fs $(TARGET_AR) ar && \
	    ln -fs $(TARGET_RANLIB) ranlib && \
	    ln -fs $(TARGET_AS) as && \
	    ln -fs $(TARGET_LD) ld && \
		export PATH="$(BOOST_DIR):$(PATH)" && \
	$(MAKE) -C $(BOOST_DIR) )
	touch $@

$(BOOST_DIR)/.stamp_staging_installed: $(BOOST_DIR)/.stamp_compiled
	export PATH="$(BOOST_DIR):$(PATH)" && \
	$(MAKE) DESTDIR=$(STAGING_DIR) -C $(BOOST_DIR) install \
		PREFIX=$(STAGING_DIR)/usr EPREFIX=$(STAGING_DIR)/usr \
		INCLUDEDIR=$(STAGING_DIR)/usr/include LIBDIR=$(STAGING_DIR)/usr/lib 
	touch $@

# the INCLUDEDIR is set to the staging dir on purpose. No need for headers
# on the target
$(BOOST_DIR)/.stamp_target_installed: $(BOOST_DIR)/.stamp_staging_installed
	export PATH="$(BOOST_DIR):$(PATH)" && \
	$(MAKE) DESTDIR=$(TARGET_DIR) -C $(BOOST_DIR) install \
		PREFIX=$(TARGET_DIR)/usr EPREFIX=$(TARGET_DIR)/usr \
		INCLUDEDIR=$(STAGING_DIR)/usr/include LIBDIR=$(TARGET_DIR)/usr/lib 
	$(TARGET_STRIP) $(TARGET_DIR)/usr/lib/libboost*
	touch $@

boost: uclibc gettext icu $(BOOST_DIR)/.stamp_target_installed

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(strip $(BR2_PACKAGE_BOOST)),y)
TARGETS+=boost
endif