#############################################################
#
# libertas-tools
#
#############################################################
USER_CROSS_COMPILE = $(STAGING_DIR)/usr/bin/$(ARCH)-linux-uclibc-

$(BUILD_DIR)/libertas-tools:
	git clone git://git.infradead.org/users/schurig/libertas-tools.git tools
	mv tools $(BUILD_DIR)/libertas-tools
	toolchain/patch-kernel.sh $(BUILD_DIR)/libertas-tools package/libertas-tools/ \*.patch

$(TARGET_DIR)/sbin/lbsdebug: $(BUILD_DIR)/libertas-tools
	make CC=$(TARGET_CC) -C $(BUILD_DIR)/libertas-tools/lbsdebug
	cp $(BUILD_DIR)/libertas-tools/lbsdebug/lbsdebug $(TARGET_DIR)/sbin
	$(TARGET_STRIP) $@

$(TARGET_DIR)/lib/firmware/libertas_cs.fw: $(TARGET_DIR)/sbin/lbsdebug
	make -C $(BUILD_DIR)/libertas-tools/fwcutter
	mkdir -p $(TARGET_DIR)/lib/firmware
	cp $(BUILD_DIR)/libertas-tools/fwcutter/*.fw $(TARGET_DIR)/lib/firmware

libertas-tools: $(TARGET_DIR)/lib/firmware/libertas_cs.fw

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(strip $(BR2_PACKAGE_LIBERTAS_TOOLS)),y)
TARGETS+=libertas-tools
endif
