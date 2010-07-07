# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/corkscrew/corkscrew-2.0.ebuild,v 1.11 2010/07/07 12:33:40 fauli Exp $

EAPI=3
inherit autotools

DESCRIPTION="a tool for tunneling SSH through HTTP proxies."
HOMEPAGE="http://www.agroman.net/corkscrew/"
SRC_URI="http://www.agroman.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=""

src_prepare() {
	# Christoph Mende <angelos@gentoo.org (23 Jun 2010)
	# Shipped configure doesn't work with some locales (bug #305771)
	# Shipped missing doesn't work with new configure, so we'll force
	# regeneration
	rm -f install-sh missing mkinstalldirs || die
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
}
