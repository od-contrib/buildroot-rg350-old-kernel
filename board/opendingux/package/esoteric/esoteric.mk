################################################################################
#
# esoteric
#
################################################################################
ESOTERIC_VERSION = master
ESOTERIC_SITE = $(call github,podulator,gmenunx,$(ESOTERIC_VERSION))
ESOTERIC_DEPENDENCIES = dejavu libpng sdl sdl_ttf sdl_gfx
ESOTERIC_INSTALL_TARGET = YES

ESOTERIC_MAKE_ENV = CROSS_COMPILE="$(TARGET_CROSS)"

ifeq ($(BR2_PACKAGE_LIBOPK),y)
ESOTERIC_DEPENDENCIES += libopk
endif

ifeq ($(BR2_PACKAGE_LIBXDGMIME),y)
ESOTERIC_DEPENDENCIES += libxdgmime
endif

define ESOTERIC_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(ESOTERIC_MAKE_ENV) $(MAKE) -C $(@D) all dist \
	  -f Makefile.$(BR2_PACKAGE_ESOTERIC_PLATFORM)
endef

define ESOTERIC_INSTALL_ESOTERIC
	cd $(@D) && ./make_opk.sh
	$(INSTALL) -D -m 0644 $(@D)/esoteric.opk $(BINARIES_DIR)/opks/
endef
ESOTERIC_POST_INSTALL_TARGET_HOOKS += ESOTERIC_INSTALL_ESOTERIC

$(eval $(generic-package))
