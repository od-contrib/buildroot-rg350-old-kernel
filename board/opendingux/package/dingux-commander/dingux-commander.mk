################################################################################
#
# DinguxCommander
#
################################################################################

DINGUX_COMMANDER_VERSION = 2020-04-04
DINGUX_COMMANDER_SITE = $(call github,glebm,rs97-commander,$(DINGUX_COMMANDER_VERSION))
DINGUX_COMMANDER_DEPENDENCIES = sdl sdl_gfx sdl_image sdl_ttf

DINGUX_COMMANDER_TARGET_PLATFORM = rg350
DINGUX_COMMANDER_CONF_OPTS += \
	-DTARGET_PLATFORM=$(DINGUX_COMMANDER_TARGET_PLATFORM) \
	-DWITH_SYSTEM_SDL_TTF=ON \
	-DWITH_SYSTEM_SDL_GFX=ON

define DINGUX_COMMANDER_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/opks
	cd $(@D) && ./package-opk.sh $(DINGUX_COMMANDER_TARGET_PLATFORM) $(DINGUX_COMMANDER_BUILDDIR) \
	  $(BINARIES_DIR)/opks/commander.opk
endef

$(eval $(cmake-package))
