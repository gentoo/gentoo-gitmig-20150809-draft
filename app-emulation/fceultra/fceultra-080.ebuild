# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fceultra/fceultra-080.ebuild,v 1.3 2002/07/24 09:50:30 cybersystem Exp $

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

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

