################################################################################
#
# devilutionx
#
################################################################################

DEVILUTIONX_VERSION = 6f7e522d
DEVILUTIONX_SITE = $(call github,glebm,devilutionx,$(DEVILUTIONX_VERSION))
DEVILUTIONX_DEPENDENCIES = sdl sdl_mixer sdl_image sdl_ttf
DEVILUTIONX_TARGET_PLATFORM = $(call qstrip,$(BR2_PACKAGE_DEVILUTIONX_TARGET_PLATFORM))

DEVILUTIONX_CONF_OPTS += \
	-DTARGET_PLATFORM=$(DEVILUTIONX_TARGET_PLATFORM) \
	-DBINARY_RELEASE=ON \
	-DVERSION_NUM=1.0.1 -DVERSION_SUFFIX="-$(DEVILUTIONX_VERSION)"

define DEVILUTIONX_INSTALL_TARGET_CMDS
	mkdir -p $(@D)/build-$(DEVILUTIONX_TARGET_PLATFORM)/
	cp $(@D)/devilutionx $(@D)/build-$(DEVILUTIONX_TARGET_PLATFORM)/
	cd $(@D) && Packaging/OpenDingux/package-opk.sh $(DEVILUTIONX_TARGET_PLATFORM)
	$(INSTALL) -D -m 0644 $(@D)/build-$(DEVILUTIONX_TARGET_PLATFORM)/devilutionx-$(DEVILUTIONX_TARGET_PLATFORM).opk \
	  $(BINARIES_DIR)/opks/
endef

$(eval $(cmake-package))
