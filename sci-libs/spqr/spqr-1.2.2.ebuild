# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/spqr/spqr-1.2.2.ebuild,v 1.1 2011/08/07 03:47:10 bicatali Exp $

EAPI=4
inherit eutils autotools

MY_PN=SPQR
DESCRIPTION="Multithreaded multifrontal sparse QR factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SPQR"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc metis static-libs tbb"
RDEPEND="sci-libs/cholmod[supernodal]
	tbb? ( dev-cpp/tbb )
	metis? ( >=sci-libs/cholmod-1.7.0-r1[metis] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-autotools.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with metis) \
		$(use_with tbb)
}

src_install() {
	default
	dodoc README.txt Doc/ChangeLog
	use doc && doins Doc/*.pdf
}
