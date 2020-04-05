# RG350 buildroot

This buildroot can be used to build RG350 cross-compilation toolchain and the OS image.

## Build toolchain

First, clone or download the repo and run:

~~~bash
make rg350_defconfig BR2_EXTERNAL=board/opendingux
~~~

You only need to run this once.

Now, `export BR2_JLEVEL=0` to compile in parallel.

Then, to build the toolchain, run:

~~~bash
make toolchain
~~~

You can also build particular libraries and packages this way, for example to build SDL and SDL_Image:

~~~bash
make sdl sdl_image
~~~

## Build OS image

Optional: If you want to include a set of default applications, emulators, and games
from various sources, run this command (you only need to do this once):

~~~bash
board/opendingux/gcw0/download_local_pack.sh
~~~

To build the OS image, run:

~~~bash
board/opendingux/gcw0/make_initial_image.sh
~~~

The image will saved to:

~~~
output/images/od-imager/images/sd_image.bin
~~~

This image can be flashed directly to the system SD card, e.g. using [balenaEtcher].

[balenaEtcher]: https://www.balena.io/etcher/

## Build OS update OPK (experimental)

To build an updater OPK that can be run directly from the device, run:

~~~bash
board/opendingux/gcw0/make_upgrade.sh
~~~
