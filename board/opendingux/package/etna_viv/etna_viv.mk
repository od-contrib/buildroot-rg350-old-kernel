################################################################################
#
# etna_viv
#
################################################################################
ETNA_VIV_VERSION = eab63aef88
ETNA_VIV_SITE = git://github.com/etnaviv/etna_viv.git
ETNA_VIV_GIT_SUBMODULES = YES
ETNA_VIV_INSTALL_STAGING = YES
# Currently, etna_viv only builds static libs, no point in installing those
# on the target.
ETNA_VIV_INSTALL_TARGET = NO

ifeq ($(BR2_PACKAGE_ETNA_VIV_ABIV2),y)
ETNA_VIV_ABI = v2
else ifeq ($(BR2_PACKAGE_ETNA_VIV_ABIV4),y)
ETNA_VIV_ABI = v4_uapi
else ifeq ($(BR2_PACKAGE_ETNA_VIV),y)
$(error No ABI version selected)
endif

ETNA_VIV_DEPENDENCIES = libpng

define ETNA_VIV_BUILD_CMDS
	touch -a $(@D)/attic/galcore_headers/include_v4_uapi/gc_hal_base.h
	touch -a $(@D)/attic/galcore_headers/include_v4_uapi/gc_hal_enum.h
	touch -a $(@D)/attic/galcore_headers/include_v4_uapi/gc_hal_driver.h
	touch -a $(@D)/attic/galcore_headers/include_v4_uapi/gc_hal_kernel_buffer.h
	touch -a $(@D)/attic/galcore_headers/include_v4_uapi/gc_hal_types.h
	$(MAKE) -C $(@D)/attic \
		GCCPREFIX="$(TARGET_CROSS)" \
		PLATFORM_CFLAGS="-D_POSIX_C_SOURCE=200809 -D_GNU_SOURCE -DLINUX" \
		PLATFORM_CXXFLAGS="-D_POSIX_C_SOURCE=200809 -D_GNU_SOURCE -DLINUX" \
		PLATFORM_LDFLAGS="-ldl -lpthread" \
		GCABI="$(ETNA_VIV_ABI)" \
		ETNAVIV_PROFILER=1
endef

define ETNA_VIV_INSTALL_STAGING_CMDS
	cp $(@D)/attic/etnaviv/libetnaviv.a $(STAGING_DIR)/usr/lib
	mkdir -p $(STAGING_DIR)/usr/include/etnaviv
	cp $(@D)/src/etnaviv/*.h $(STAGING_DIR)/usr/include/etnaviv
	cp $(@D)/attic/etnaviv/*.h $(STAGING_DIR)/usr/include/etnaviv
endef

$(eval $(generic-package))
