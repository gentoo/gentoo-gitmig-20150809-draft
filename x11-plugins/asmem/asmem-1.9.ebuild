# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asmem/asmem-1.9.ebuild,v 1.6 2004/03/26 23:10:05 aliz Exp $

inherit eutils

IUSE=""
DESCRIPTION="Memory statistics monitor utility for X Windows"
SRC_URI="http://www.tigr.net/afterstep/download/asmem/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1

	make DESTDIR=${D} install || die
	dodoc CHANGES INSTALL LICENSE README
}
