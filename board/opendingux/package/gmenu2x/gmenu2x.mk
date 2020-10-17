#############################################################
#
# gmenu2x
#
#############################################################
ifeq ($(BR2_PACKAGE_GMENU2X_PLATFORM),"rg350m")
# https://github.com/od-contrib/gmenu2x/tree/rg350m-wip
GMENU2X_VERSION = 6ca1ad4
else
GMENU2X_VERSION = 7eaa794
endif
GMENU2X_SITE = $(call github,od-contrib,gmenu2x,$(GMENU2X_VERSION))
GMENU2X_DEPENDENCIES = sdl sdl_ttf sdl_gfx dejavu libpng
GMENU2X_CONF_OPTS = -DBIND_CONSOLE=ON -DPLATFORM=$(BR2_PACKAGE_GMENU2X_PLATFORM)

ifneq ($(BR2_PACKAGE_GMENU2X_WIDTH),"")
GMENU2X_CONF_OPTS += -DSCREEN_WIDTH=$(BR2_PACKAGE_GMENU2X_WIDTH) -DSCREEN_HEIGHT=$(BR2_PACKAGE_GMENU2X_HEIGHT)
endif

ifneq ($(BR2_PACKAGE_GMENU2X_DEFAULT_FALLBACK_FONTS),"")
GMENU2X_CONF_OPTS += -DDEFAULT_FALLBACK_FONTS=$(BR2_PACKAGE_GMENU2X_DEFAULT_FALLBACK_FONTS)
endif

ifeq ($(BR2_PACKAGE_GMENU2X_SHOW_CLOCK),y)
GMENU2X_CONF_OPTS += -DCLOCK=ON
else
GMENU2X_CONF_OPTS += -DCLOCK=OFF
endif

ifeq ($(BR2_PACKAGE_GMENU2X_CPUFREQ),y)
GMENU2X_CONF_OPTS += -DCPUFREQ=ON
else
GMENU2X_CONF_OPTS += -DCPUFREQ=OFF
endif

ifeq ($(BR2_PACKAGE_LIBOPK),y)
GMENU2X_DEPENDENCIES += libopk
endif

ifeq ($(BR2_PACKAGE_LIBXDGMIME),y)
GMENU2X_DEPENDENCIES += libxdgmime
endif

$(eval $(cmake-package))
