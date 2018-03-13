#
# Copyright (C) 2018 wongsyrone 
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray
PKG_VERSION:=custom
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/v2ray
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A platform for building proxies to bypass network restrictions
	DEPENDS:=+ca-bundle
endef

define Package/v2ray/description
	A platform for building proxies to bypass network restrictions
endef

# Use go build and copy binary to the corresponding location
define Build/Compile
true
endef

define Package/v2ray/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/v2ray.init $(1)/etc/init.d/v2ray
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/v2ray.config $(1)/etc/config/v2ray
	$(INSTALL_DIR) $(1)/etc/v2ray
	$(INSTALL_DATA) ./shipped/geo*.dat $(1)/etc/v2ray/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./shipped/v2ray $(1)/usr/sbin/v2ray
	$(INSTALL_BIN) ./shipped/v2ctl $(1)/usr/sbin/v2ctl
endef

$(eval $(call BuildPackage,v2ray)) 
