################################################################################
#
# fluidsynth v1 - older version for binary backwards compatibility
#
################################################################################

FLUIDSYNTH1_VERSION = 1.1.11
FLUIDSYNTH1_SITE = $(call github,FluidSynth,fluidsynth,v$(FLUIDSYNTH1_VERSION))
FLUIDSYNTH1_LICENSE = LGPL-2.1+
FLUIDSYNTH1_LICENSE_FILES = LICENSE
FLUIDSYNTH1_INSTALL_STAGING = YES
FLUIDSYNTH1_DEPENDENCIES = libglib2

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_ALSA_LIB),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-alsa=1
FLUIDSYNTH1_DEPENDENCIES += alsa-lib
else
FLUIDSYNTH1_CONF_OPTS += -Denable-alsa=0
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_DBUS),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-dbus=1
FLUIDSYNTH1_DEPENDENCIES += dbus
else
FLUIDSYNTH1_CONF_OPTS += -Denable-dbus=0
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_FLOATS),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-floats=1
else
FLUIDSYNTH1_CONF_OPTS += -Denable-floats=0
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_JACK2),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-jack=1
FLUIDSYNTH1_DEPENDENCIES += jack2
else
FLUIDSYNTH1_CONF_OPTS += -Denable-jack=0
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_LIBSNDFILE),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-libsndfile=1
FLUIDSYNTH1_DEPENDENCIES += libsndfile
else
FLUIDSYNTH1_CONF_OPTS += -Denable-libsndfile=0
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_PORTAUDIO),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-portaudio=1
FLUIDSYNTH1_DEPENDENCIES += portaudio
else
FLUIDSYNTH1_CONF_OPTS += -Denable-portaudio=0
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_PULSEAUDIO),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-pulseaudio=1
FLUIDSYNTH1_DEPENDENCIES += pulseaudio
else
FLUIDSYNTH1_CONF_OPTS += -Denable-pulseaudio=0
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH1_READLINE),y)
FLUIDSYNTH1_CONF_OPTS += -Denable-readline=1
FLUIDSYNTH1_DEPENDENCIES += readline
else
FLUIDSYNTH1_CONF_OPTS += -Denable-readline=0
endif

$(eval $(cmake-package))
