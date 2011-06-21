# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qd/qd-2.3.11.ebuild,v 1.3 2011/06/21 15:08:06 jlec Exp $

EAPI=4

inherit autotools eutils fortran-2

DESCRIPTION="Quad-double and double-double float arithmetics"
HOMEPAGE="http://crd.lbl.gov/~dhbailey/mpdist/"
SRC_URI="http://crd.lbl.gov/~dhbailey/mpdist/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="fortran"

DEPEND="
	fortran? ( virtual/fortran )
	"
RDEPEND="${DEPEND}"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-2.3.7-test.patch \
		"${FILESDIR}"/${P}-configure-version.patch \
		"${FILESDIR}"/${P}-docpath.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable fortran enable_fortran)
}

src_install() {
	default
	dosym /usr/include/qd/qd_real.h /usr/include/qd/qd.h
	dosym /usr/include/qd/dd_real.h /usr/include/qd/dd.h
}
