# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/fetch/fetch-1.0.ebuild,v 1.4 2011/06/15 15:47:42 jer Exp $

DESCRIPTION="Fetch is a simple, fast, and flexible HTTP download tool built on the HTTP Fetcher library."
HOMEPAGE="http://sourceforge.net/projects/fetch/"
SRC_URI="mirror://sourceforge/fetch/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-libs/http-fetcher-1.0.1"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README INSTALL LICENSE
	dohtml docs/*.html
}
