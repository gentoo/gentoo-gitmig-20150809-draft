# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/spqr/spqr-1.1.0.ebuild,v 1.2 2009/10/23 03:48:29 markusle Exp $

EAPI=2
inherit eutils autotools

MY_PN=SPQR
DESCRIPTION="Multithreaded multifrontal sparse QR factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SPQR"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc metis tbb"
RDEPEND="sci-libs/cholmod[supernodal]
	tbb? ( dev-cpp/tbb )
	metis? ( >=sci-libs/cholmod-1.7.0-r1[metis] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	cd "${S}"
	eautoreconf
}

src_configure() {
	econf \
		$(use_with metis) \
		$(use_with tbb)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Doc/*.pdf || die
	fi
}
