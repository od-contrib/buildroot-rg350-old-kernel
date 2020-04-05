#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

mkdir -p /media/data/apps /media/data/local/home

mount -o remount,ro /media

for i in bin etc home lib sbin share; do
	mkdir -p /usr/local/$i
done

mkdir -p /var/run/sudo /var/tmp /var/log /var/lib
chmod 777 /var/tmp /var/log
