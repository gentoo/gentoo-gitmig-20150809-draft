# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/fetch/fetch-1.0-r1.ebuild,v 1.1 2010/01/03 06:52:15 vostorga Exp $

DESCRIPTION="Fetch is a simple, fast, and flexible HTTP download tool built on the HTTP Fetcher library."
HOMEPAGE="http://cs.nmu.edu/~lhanson/fetch/"
SRC_URI="http://cs.nmu.edu/~lhanson/fetch/dls/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/http-fetcher-1.0.1"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	sed -i -e "/^ld_rpath/d" configure || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README INSTALL
	dohtml docs/*.html
}
