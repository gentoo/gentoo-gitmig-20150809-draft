# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/arprec/arprec-2.2.9.ebuild,v 1.1 2012/03/06 18:00:03 bicatali Exp $

EAPI=4

inherit eutils fortran-2 autotools

DESCRIPTION="Arbitrary precision float arithmetics and functions"
HOMEPAGE="http://crd.lbl.gov/~dhbailey/mpdist/"
SRC_URI="http://crd.lbl.gov/~dhbailey/mpdist/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="doc fortran qd static-libs"

DEPEND="fortran? ( virtual/fortran )
	qd? ( sci-libs/qd[fortran=] )"
RDEPEND="${DEPEND}"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--enable-shared \
		$(use_enable static-libs static) \
		$(use_enable fortran enable_fortran) \
		$(use_enable qd enable_qd)
}

src_compile() {
	emake
	use fortran && emake toolkit
}

src_install() {
	default
	if use fortran; then
		cd toolkit
		./mathinit || die "mathinit failed"
		exeinto /usr/libexec/${PN}
		doexe mathtool
		insinto /usr/libexec/${PN}
		doins *.dat
		newdoc README README.mathtool
	fi
	use doc || rm "${ED}"/usr/share/doc/${PF}/*.pdf
}
