# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pyddr/pyddr-0.7.0.ebuild,v 1.2 2003/09/10 19:37:29 vapier Exp $

DESCRIPTION="Dance Dance Revolution!  You need this game more than Frozen Bubble"
HOMEPAGE="http://www.icculus.org/pyddr/"
SRC_URI="http://www.icculus.org/pyddr/${P}.tar.gz"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86"
IUSE=""

RDEPEND="games-arcade/pyddr-songs
	dev-python/pygame
	media-libs/libvorbis
	media-libs/sdl-mixer"

src_compile() {
	echo "#!/bin/bash" > pyddr
	echo "cd /usr/share/games/pyddr" >> pyddr
	echo "python pyddr.py" >> pyddr
}

src_install() {
	insinto /usr/share/games/pyddr
	doins *.py

	cp -R {sound,images,utils,themes} ${D}/usr/share/games/pyddr

	fowners root.games /usr/share/games/pyddr/*

	# kernel module for dance mat
	chown root.root -R ddrmat
	chmod -R 755 ddrmat
	mv ddrmat ${D}/usr/share/pyddr

	insinto /etc
	newins pyddr.posix.cfg pyddr.cfg

	into /usr
	dobin pyddr

	dodoc CREDITS ChangeLog INSTALL LICENSE README *.txt
	dohtml docs/README.html
	doman docs/man/*
}


pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/app-games/${P}/${P}.ebuild config\""
	einfo "to install the ddrmat kernel module, which allows you to use the"
	einfo "the DDR mat with pyDDR"
}

pkg_config() {
	ebegin "Compiling kernel module"
	gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes \
		-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing \
		-fno-common -pipe -mpreferred-stack-boundary=2 -falign-functions=4 \
		-DMODULE -DMODVERSIONS -include \
		/usr/src/linux/include/linux/modversions.h \
		-c -o /usr/share/pyddr/ddrmat/ddrmat.o \
		/usr/share/pyddr/ddrmat/ddrmat.c &>/dev/null
	eend $?

	ebegin "Installing kernel module"
	cp /usr/share/pyddr/ddrmat/ddrmat.o \
		/lib/modules/${KV}/kernel/drivers/char/joystick
	eend $?

	ebegin "Calculating modules dependencies"
	depmod -ae
	eend $?

	ebegin "Loading the ddrmat module"
	modprobe ddrmat gc=0,7
	eend $?
}
