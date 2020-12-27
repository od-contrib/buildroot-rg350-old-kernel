#############################################################
#
# love2d
#
#############################################################
LOVE2D_VERSION = 11.3
LOVE2D_SITE = $(call github,love2d,love,$(LOVE2D_VERSION))
LOVE2D_LICENSE = unknown
LOVE2D_LICENSE_FILES = license.txt

LOVE2D_AUTORECONF = YES
LOVE2D_DEPENDENCIES = libgles luainterpreter sdl2 \
					  devil libmodplug libvorbis

ifeq ($(BR2_PACKAGE_MPG123),y)
LOVE2D_DEPENDENCIES += mpg123
else
LOVE2D_CONF_OPTS += --disable-mpg123
endif

ifeq ($(BR2_PACKAGE_OPENAL),y)
LOVE2D_DEPENDENCIES += openal
else
LOVE2D_CONF_OPTS += --disable-implementation-audio-openal
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
LOVE2D_DEPENDENCIES += freetype
else
LOVE2D_CONF_OPTS += --disable-implementation-font-freetype
endif

ifeq ($(BR2_PACKAGE_PHYSFS),y)
LOVE2D_DEPENDENCIES += physfs
else
LOVE2D_CONF_OPTS += --disable-implementation-filesystem-physfs
endif

define LOVE2D_PREPARE_BUILD
	( cd $(@D) ; \
		cp platform/unix/configure.ac platform/unix/Makefile.am . ; \
		$(SHELL) platform/unix/genmodules ; \
		$(AUTOHEADER) ; \
		$(LIBTOOLIZE) )
endef
LOVE2D_PRE_CONFIGURE_HOOKS += LOVE2D_PREPARE_BUILD

$(eval $(autotools-package))
