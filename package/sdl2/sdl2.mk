################################################################################
#
# sdl2
#
################################################################################

SDL2_VERSION = 68554ae95f
SDL2_SITE = $(call github,pcercuei,SDL2,$(SDL2_VERSION))
SDL2_LICENSE = zlib
SDL2_LICENSE_FILES = COPYING.txt
SDL2_INSTALL_STAGING = YES

LIBGLES_DEPENDENCIES = mesa3d-etna_viv

define SDL2_VGA_PATCH
	$(APPLY_PATCHES) $(@D) $(SDL2_PKGDIR) 0001-sdl2-vga.patch.conditional
endef

ifeq ($(BR2_TARGET_DEVICE),"rg350m")
SDL2_POST_PATCH_HOOKS += SDL2_VGA_PATCH
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
SDL2_DEPENDENCIES += $(LIBGLES_DEPENDENCIES)
SDL2_CONF_OPTS += --enable-video-opengles
else
SDL2_CONF_OPTS += --disable-video-opengles
endif

ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
SDL2_DEPENDENCIES += $(LIBEGL_DEPENDENCIES)
endif

SDL2_CONF_OPTS += --enable-video-fbdev

# Note: SDL2 looks for X11 headers in host dirs, so if you want to build SDL2
#       with X11 support, better make it safe for cross compilation first.
SDL2_CONF_OPTS += --disable-video-x11

ifeq ($(BR2_PACKAGE_DIRECTFB),y)
SDL2_DEPENDENCIES += directfb
SDL2_CONF_OPTS += --enable-video-directfb
SDL2_CONF_ENV += ac_cv_path_DIRECTFBCONFIG=$(STAGING_DIR)/usr/bin/directfb-config
else
SDL2_CONF_OPTS += --disable-video-directfb
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SDL2_DEPENDENCIES += alsa-lib
SDL2_CONF_OPTS += --enable-alsa --disable-oss
else
SDL2_CONF_OPTS += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
SDL2_DEPENDENCIES += pulseaudio
SDL2_CONF_OPTS += --enable-pulseaudio
else
SDL2_CONF_OPTS += --disable-pulseaudio
endif

SDL2_CONF_OPTS += --disable-esd

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
SDL2_CONF_OPTS += --enable-libudev
else
SDL2_CONF_OPTS += --disable-libudev
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
SDL2_CONF_OPTS += --enable-dbus
else
SDL2_CONF_OPTS += --disable-dbus
endif

# OpenDingux hack: We've got tslib to make porting easier, but we've got no
#                  touch screen, so having SDL try to use tslib is pointless.
# ifeq ($(BR2_PACKAGE_TSLIB),y)
# SDL2_DEPENDENCIES += tslib
# SDL2_CONF_OPTS += --enable-input-tslib
# else
SDL2_CONF_OPTS += --disable-input-tslib
# endif

SDL2_CONF_OPTS += --disable-rpath

define SDL2_FIXUP_SDL2_CONFIG
	$(SED) 's%^prefix=.*%prefix=$(STAGING_DIR)/usr%' \
		$(STAGING_DIR)/usr/bin/sdl2-config
	$(SED) 's%^exec_prefix=.*%exec_prefix=$${prefix}%' \
		$(STAGING_DIR)/usr/bin/sdl2-config
endef

define SDL2_REMOVE_SDL2_CONFIG
	rm $(TARGET_DIR)/usr/bin/sdl2-config
endef

SDL2_POST_INSTALL_TARGET_HOOKS += SDL2_REMOVE_SDL2_CONFIG
SDL2_POST_INSTALL_STAGING_HOOKS += SDL2_FIXUP_SDL2_CONFIG

$(eval $(autotools-package))
