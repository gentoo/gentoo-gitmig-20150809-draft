# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fceultra/fceultra-070.ebuild,v 1.1 2002/03/11 05:30:00 woodchip Exp $

MY_P=fceu
S=${WORKDIR}/${MY_P}
DESCRIPTION="A portable NES/Famicom Emulator"
SRC_URI="http://fceultra.sourceforge.net/dev/${MY_P}${PV}src.tar.gz"
HOMEPAGE="http://fceultra.sourceforge.net"

DEPEND=">=media-libs/svgalib-1.4.2"

src_compile() {
	mv Makefile.base Makefile.orig
	sed -e "s:\${TFLAGS}:\${TFLAGS} ${CFLAGS}:" \
		Makefile.orig > Makefile.base

	make -f Makefile.linuxvga || die
}

src_install() {
	dobin fce
	cd Documentation
	dodoc LICENSE README RELEASE-NOTES fcs.txt porting.txt \
		rel/readme-linux.txt 
}
