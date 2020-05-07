################################################################################
#
# bennugd
#
################################################################################

BENNUGD_VERSION = master
BENNUGD_SITE = $(call github,blackz1982,bennugd_cmake,$(BENNUGD_VERSION))
BENNUGD_DEPENDENCIES = libpng sdl sdl_mixer openssl
BENNUGD_INSTALL_TARGET = YES

$(eval $(cmake-package))