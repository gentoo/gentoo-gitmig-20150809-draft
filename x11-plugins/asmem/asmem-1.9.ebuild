# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asmem/asmem-1.9.ebuild,v 1.1 2003/06/05 11:05:03 robh Exp $

DESCRIPTION="Memory statistics monitor utility for X Windows"
SRC_URI="http://www.tigr.net/afterstep/download/asmem/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch
}

src_install () {
        dodir /usr/bin
        dodir /usr/share/man/man1

        make DESTDIR=${D} install || die
	dodoc CHANGES INSTALL LICENSE README
}
