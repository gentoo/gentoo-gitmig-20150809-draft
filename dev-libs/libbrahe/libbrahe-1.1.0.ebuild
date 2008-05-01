# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libbrahe/libbrahe-1.1.0.ebuild,v 1.1 2008/05/01 00:30:01 dev-zero Exp $

inherit autotools eutils

DESCRIPTION="A Heterogenous C Library of Numeric Functions"
HOMEPAGE="http://www.coyotegulch.com/products/brahe/"
SRC_URI="http://www.coyotegulch.com/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-missing_libs.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS
}
