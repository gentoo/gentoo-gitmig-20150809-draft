#!/bin/bash

DEV1=/opt/pxes-0.6/stock/dist/dev
DEV2=/opt/pxes-0.6/stock/initrd/dev

if [ ! -d ${DEV1} ]; then
	mkdir -p ${DEV1}
fi

cd ${DEV1}
mkdir input pts
mknod agpgart c 10 175
mknod audio0 c 14 4
ln -s audio0 audio
mknod console c 5 1
mknod dsp c 14 3
mknod dsp1 c 14 19
for i in 0 1 2 3 4 5 6 7; do
	mknod fb${i} c 29 $(( ${i} * 32 ))
done
ln -s fb0 fb
mknod fd0 b 2 0
mknod fd1 b 2 1
mknod fd0H1440 b 2 28
mknod gart c 174 0
mknod hda b 3 0
for i in 1 2 3 4 5 6 7 8 9; do
	mknod hda${i} b 3 ${i}
done
mknod hdb b 3 64
mknod hdc b 22 0
ln -s hdc cdrom
mknod hdd b 22 64
mknod kbd c 11 0
mknod lp0 c 6 0
mknod lp1 c 6 1
chmod 666 lp0 lp1
chgrp lp lp0 lp1
mknod mem c 1 1
mknod mixer c 14 0
mknod null c 1 3
mknod openprm c 10 139
mknod psaux c 10 1
ln -s psaux mouse
mknod ptmx c 5 2
for i in 0 1 2 3 4 5 6 7 8 9; do
	mknod ptyp${i} c 2 ${i}
	chmod 666 ptyp${i}
	chgrp tty ptyp${i}
done
mknod ram b 1 1
mknod tty c 5 0
chmod 666 tty
for i in 0 1 2 3 4 5 6 7 8 9; do
	mknod tty${i} c 4 ${i}
done
for i in 0 1 2 3; do
	mknod ttyS${i} c 4 $(( ${i} + 64 ))
	chgrp tty ttyS${i}
done
for i in 0 1 2 3 4 5 6 7 8 9; do
	mknod ttyp${i} c 3 ${i}
	chgrp tty ttyp${i}
	chmod 666 ttyp${i}
done
mknod zero c 1 5
cd input
mknod keyboard c 10 150
chmod 600 keyboard
mknod mice c 13 63

if [ ! -d ${DEV2} ]; then
	mkdir -p ${DEV2}
fi

cd ${DEV2}
mknod console c 5 1
mknod hda b 3 0
mknod hdb b 3 64
mknod hdc b 22 0
ln -s hdc cdrom
mknod hdd b 22 64
mknod lvm b 109 0
mknod null c 1 3
mknod ram b 1 1
mknod sda2 b 8 2
chgrp disk sda2
chmod 660 sda2
mknod systty c 4 0
for i in 0 1 2 3 4; do
	mknod tty${i} c 4 ${i}
done
mknod zero c 1 5
