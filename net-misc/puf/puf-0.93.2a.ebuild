# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/puf/puf-0.93.2a.ebuild,v 1.3 2004/07/01 21:45:49 squinky86 Exp $

DESCRIPTION="A download tool for UNIX-like systems."
SRC_URI="mirror://sourceforge/puf/${P}.tar.gz"
HOMEPAGE="http://puf.sourceforge.net/"

DEPEND="virtual/libc"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README TODO
}
