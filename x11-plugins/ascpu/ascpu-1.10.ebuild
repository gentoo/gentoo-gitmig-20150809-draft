# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/ascpu/ascpu-1.10.ebuild,v 1.4 2004/09/02 18:22:39 pvdabeel Exp $

inherit eutils

IUSE=""
DESCRIPTION="CPU statistics monitor utility for X Windows"
SRC_URI="http://www.tigr.net/afterstep/download/ascpu/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ppc ~mips"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1

	make DESTDIR=${D} install || die
	dodoc README INSTALL LICENSE
}
