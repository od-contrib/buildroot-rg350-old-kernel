################################################################################
#
## hocoslamfy
#
#################################################################################
HOCOSLAMFY_VERSION = rg350
HOCOSLAMFY_SITE = $(call github,jamesofarrell,hocoslamfy,$(HOCOSLAMFY_VERSION))
HOCOSLAMFY_AUTORECONF = YES
HOCOSLAMFY_INSTALL_STAGING = YES

HOCOSLAMFY_DEPENDENCIES += libshake

HOCOSLAMFY_MAKE_ENV = CROSS_COMPILE="$(TARGET_CROSS)"

define HOCOSLAMFY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(HOCOSLAMFY_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOCOSLAMFY_INSTALL_OPK_IMAGES
	$(TARGET_MAKE_ENV) $(HOCOSLAMFY_MAKE_ENV) $(MAKE) -C $(@D) opk
	$(INSTALL) -D -m 0644 $(@D)/hocoslamfy-od.opk $(BINARIES_DIR)/opks/
endef
HOCOSLAMFY_POST_INSTALL_TARGET_HOOKS += HOCOSLAMFY_INSTALL_OPK_IMAGES


$(eval $(generic-package))
