# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ctwm/ctwm-3.6.ebuild,v 1.2 2003/11/07 16:55:30 usata Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A clean, light window manager."

SRC_URI="http://ctwm.free.lp.se/dist/${P}.tar.gz"
HOMEPAGE="http://ctwm.free.lp.se/"

SLOT="0"
KEYWORDS="x86"
LICENSE="MIT"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	xmkmf || die
	make || die
}

src_install() {
	make BINDIR=/usr/bin \
		 LIBDIR=/etc/X11 \
		 MANPATH=/usr/share/man \
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
