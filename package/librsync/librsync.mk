################################################################################
#
# librsync
#
################################################################################

LIBRSYNC_VERSION = 2.3.1
LIBRSYNC_SITE = $(call github,librsync,librsync,v$(LIBRSYNC_VERSION))
LIBRSYNC_LICENSE = LGPL-2.1+
LIBRSYNC_LICENSE_FILES = COPYING
LIBRSYNC_CPE_ID_VENDOR = librsync_project
LIBRSYNC_INSTALL_STAGING = YES
LIBRSYNC_DEPENDENCIES = host-pkgconf zlib bzip2 popt

$(eval $(cmake-package))
