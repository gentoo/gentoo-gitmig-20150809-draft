# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.7.ebuild,v 1.1 2004/10/25 12:21:29 ka0ttic Exp $

DESCRIPTION="Flexible remote checksum-based differencing"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://librsync.sf.net/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

src_compile() {
	econf --enable-shared || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc COPYING NEWS INSTALL AUTHORS THANKS README TODO
}
