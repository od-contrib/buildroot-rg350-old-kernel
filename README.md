# RG350 buildroot (new userland, old kernel)

This buildroot can be used to build RG350 cross-compilation toolchain and the OS image.

## Build toolchain

First, clone the repository with its submodules:

~~~bash
git clone --recurse-submodules https://github.com/od-contrib/buildroot-rg350-old-kernel.git
cd buildroot-rg350-old-kernel
~~~

Then, run this to configure the buildroot:

~~~bash
make rg350_defconfig BR2_EXTERNAL=board/opendingux:opks
~~~

You only need to run the command above once.

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

Place any additional OPKs that you want into the `output/images/opks` directory.

To build the OS image, run:

~~~bash
board/opendingux/gcw0/make_initial_image.sh rg350
~~~

The image will saved to:

~~~
output-rg350/images/
~~~

This image can be flashed directly to the system SD card, e.g. using [balenaEtcher].

[balenaEtcher]: https://www.balena.io/etcher/

## Build OS update OPK (experimental)

To build an updater OPK that can be run directly from the device, run:

~~~bash
board/opendingux/gcw0/make_upgrade.sh
~~~


## Credits

This repository started as a fork of <https://github.com/TonyJih/RG350_buildroot> (itself a fork of <https://github.com/gcwnow/buildroot>) grafted on top of the latest upstream <https://github.com/buildroot/buildroot> with some updates from <https://github.com/OpenDingux/buildroot>.

The commits from <https://github.com/TonyJih/RG350_buildroot> were all squashed, as rebasing on top of a 2020 buildroot from a 2014 one would otherwise be difficult.
