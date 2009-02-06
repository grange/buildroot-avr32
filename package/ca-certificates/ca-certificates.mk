#############################################################
#
# ca-certificates
#
#############################################################

package/ca-certificates/ca-bundle.crt:
	package/ca-certificates/mkcabundle.pl > $@

$(TARGET_DIR)/usr/lib/ssl/cert.pem: package/ca-certificates/ca-bundle.crt
	mkdir -p $(TARGET_DIR)/usr/lib/ssl/certs/
	mkdir -p $(TARGET_DIR)/usr/lib/ssl/CA/private
	cp package/ca-certificates/ca-bundle.crt $(TARGET_DIR)/usr/lib/ssl/certs
	ln -s certs/ca-bundle.crt $(TARGET_DIR)/usr/lib/ssl/cert.pem
	
ca-certificates: $(TARGET_DIR)/usr/lib/ssl/cert.pem

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(strip $(BR2_PACKAGE_CA_CERTIFICATES)),y)
TARGETS+=ca-certificates
endif