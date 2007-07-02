# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libredblack/libredblack-1.2.ebuild,v 1.8 2007/07/02 14:59:53 peper Exp $

DESCRIPTION="RedBlack Balanced Tree Searching and Sorting Library"
HOMEPAGE="http://libredblack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="virtual/libc"

#RESTRICT="mirror"

src_compile() {
	econf --libexecdir=/usr/lib || die "configure failure"
	emake || die "compile failure"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	rm example*.o
	cp -a example* ${D}/usr/share/doc/${PF}
}
