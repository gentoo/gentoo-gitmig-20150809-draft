# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/darcnes/darcnes-0401-r1.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

DESCRIPTION="A multi-system emulator"
SRC_URI="http://www.dridus.com/~nyef/darcnes/download/dn9b${PV}.tgz"
HOMEPAGE="http://www.dridus.com/~nyef/darcnes/"

SLOT="0"
KEYWORDS="x86 -ppc"
LICENSE="GPL-2"
IUSE="X gtk"

DEPEND=">=media-libs/svgalib-1.4.2
	X? ( virtual/x11 )
	gtk? ( =x11-libs/gtk+-1.2* )"

S=${WORKDIR}/${PN}

src_compile() {

	cp cd_unix.c cd_unix.c.orig
	cat cd_unix.c.orig | sed "s:CDROM_DEVICE \"/dev/cdrom\"$:CDROM_DEVICE \"/dev/cdroms/cdrom0\":"\
	> cd_unix.c
	cp Makefile Makefile.orig
	if [ "`use X`" ]
	then
		if [ "`use gtk`" ]
		then
			cat Makefile.orig | sed "s:^TARGET?=Linux_X$:TARGET?=Linux_GTK:" \
			> Makefile
		fi
		make || die
	fi
	cat Makefile.orig | sed "s:^TARGET?=Linux_X$:TARGET?=Linux_svgalib:" \
	> Makefile
	make || die

}

src_install() {
	exeinto /usr/bin
	doexe sdarcnes
	if [ "`use X`" ]
	then
		exeinto /usr/bin
		doexe darcnes
	fi
	dodoc readme

}
