# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libredblack/libredblack-1.3.ebuild,v 1.4 2004/06/13 20:29:45 dholm Exp $

DESCRIPTION="RedBlack Balanced Tree Searching and Sorting Library"
HOMEPAGE="http://libredblack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

#RESTRICT="nomirror"

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
