################################################################################
#
# devilutionx
#
################################################################################

DEVILUTIONX_VERSION = ea2b4450
DEVILUTIONX_SITE = $(call github,glebm,devilutionx,$(DEVILUTIONX_VERSION))
DEVILUTIONX_DEPENDENCIES = sdl sdl_mixer sdl_image sdl_ttf
DEVILUTIONX_TARGET_PLATFORM = $(call qstrip,$(BR2_PACKAGE_DEVILUTIONX_TARGET_PLATFORM))

DEVILUTIONX_CONF_OPTS += \
	-D$(call UPPERCASE,$(DEVILUTIONX_TARGET_PLATFORM))=ON \
	-DBINARY_RELEASE=ON

define DEVILUTIONX_INSTALL_TARGET_CMDS
	mkdir -p $(@D)/build-$(DEVILUTIONX_TARGET_PLATFORM)/
	cp $(@D)/devilutionx $(@D)/build-$(DEVILUTIONX_TARGET_PLATFORM)/
	cd $(@D) && Packaging/OpenDingux/package-opk.sh $(DEVILUTIONX_TARGET_PLATFORM)
	$(INSTALL) -m 0755 -D $(@D)/build-$(DEVILUTIONX_TARGET_PLATFORM)/devilutionx-$(DEVILUTIONX_TARGET_PLATFORM).opk \
		$(BINARIES_DIR)/opks/devilutionx-$(DEVILUTIONX_TARGET_PLATFORM).opk
endef

$(eval $(cmake-package))
