# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libredblack/libredblack-1.2.ebuild,v 1.1 2003/05/16 07:30:55 george Exp $

DESCRIPTION="RedBlack Balanced Tree Searching and Sorting Library"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

#RESTRICT="nomirror"

src_compile() {
	econf --libexecdir=/usr/lib || "configure failure"
	emake || die "compile failure"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	rm example*.o
	cp -a example* ${D}/usr/share/doc/${PF}
}
