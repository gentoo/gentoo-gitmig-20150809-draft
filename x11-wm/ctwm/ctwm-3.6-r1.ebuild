# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ctwm/ctwm-3.6-r1.ebuild,v 1.2 2004/02/06 06:53:30 usata Exp $

IUSE=""

DESCRIPTION="A clean, light window manager."

SRC_URI="http://ctwm.free.lp.se/dist/${P}.tar.gz
	http://slpc1.epfl.ch/public/software/ctwm/${PN}-images.tar.gz"
HOMEPAGE="http://ctwm.free.lp.se/"

SLOT="0"
KEYWORDS="x86"
LICENSE="MIT"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack ${PN}-images.tar.gz
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	xmkmf || die
	make TWMDIR=/usr/share/${PN} || die
}

src_install() {
	make BINDIR=/usr/bin \
		 MANPATH=/usr/share/man \
		 TWMDIR=/usr/share/${PN} \
		 DESTDIR=${D} install || die

	make MANPATH=/usr/share/man \
		DOCHTMLDIR=/usr/share/doc/${PF}/html \
		DESTDIR=${D} install.man || die

	echo "#!/bin/sh" > ctwm
	echo "/usr/bin/ctwm" >> ctwm

	exeinto /etc/X11/Sessions
	doexe ctwm

	dodoc CHANGES README PROBLEMS
}
