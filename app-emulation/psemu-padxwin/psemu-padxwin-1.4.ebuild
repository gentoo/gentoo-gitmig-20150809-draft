# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-padxwin/psemu-padxwin-1.4.ebuild,v 1.8 2003/02/13 07:16:01 vapier Exp $

DESCRIPTION="PSEmu plugin to use the keyboard as a gamepad"
HOMEPAGE="http://www.pcsx.net"
LICENSE="freedist"
KEYWORDS="x86 -ppc"
SLOT="0"
DEPEND="x11-libs/gtk+"
SRC_URI="http://linux.pcsx.net/downloads/plugins/padXwin-${PV}.tgz"
S=${WORKDIR}
IUSE=""

src_compile() {
	cd src
	( echo CFLAGS = ${CFLAGS}
	  sed 's/CFLAGS =/CFLAGS +=/' < Makefile ) >Makefile.gentoo
	emake -f Makefile.gentoo
}

src_install () {
	insinto /usr/lib/psemu/plugins
	doins src/libpad*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	dodoc ReadMe.txt
}

