# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
#$Header: /var/cvsroot/gentoo-x86/net-www/prozilla/prozilla-1.3.6.ebuild,v 1.7 2002/09/26 21:14:31 blizzy Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A download manager"
SRC_URI="http://prozilla.genesys.ro/packages/prozilla/tarballs/${P}.tar.gz"
HOMEPAGE="http://prozilla.genesys.ro"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {
    ./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--sysconfdir=/etc || die
	emake || die
}

src_install () {
	make DESTDIR=${D} \
		sysconfdir=${D}/etc \
		install || die

	dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO
}
