# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/prozilla/prozilla-1.3.6-r1.ebuild,v 1.2 2004/10/03 21:59:33 swegener Exp $

DESCRIPTION="A download manager"
HOMEPAGE="http://prozilla.genesys.ro/"
SRC_URI="http://prozilla.genesys.ro/downloads/prozilla/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2"

src_compile() {
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--sysconfdir=/etc || die
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} \
		sysconfdir=${D}/etc \
		install || die "make install failed"
	dodoc ANNOUNCE AUTHORS CREDITS ChangeLog FAQ NEWS README TODO
}
