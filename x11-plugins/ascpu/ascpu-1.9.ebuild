# Copyright 2002 Dwight Schauer
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/ascpu/ascpu-1.9.ebuild,v 1.5 2003/09/06 05:56:25 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="CPU statistics monitor utility for X Windows"
SRC_URI="http://www.tigr.net/afterstep/download/ascpu/${P}.tar.gz"
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
	dodoc README INSTALL LICENSE
}
