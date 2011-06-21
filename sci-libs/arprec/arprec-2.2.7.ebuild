# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/arprec/arprec-2.2.7.ebuild,v 1.3 2011/06/21 15:42:20 jlec Exp $

EAPI=4

inherit eutils fortran-2

DESCRIPTION="Arbitrary precision float arithmetics and functions"
HOMEPAGE="http://crd.lbl.gov/~dhbailey/mpdist/"
SRC_URI="http://crd.lbl.gov/~dhbailey/mpdist/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE="fortran qd"

DEPEND="
	fortran? ( virtual/fortran )
	qd? ( sci-libs/qd )"
RDEPEND="${DEPEND}"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
}

src_configure() {
	econf \
		$(use_enable fortran enable_fortran) \
		$(use_enable qd enable_qd)
}

src_compile() {
	emake
	if use fortran; then
		emake toolkit
	fi
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
		docinto toolkit
		dodoc README
	fi
	cd "${D}"/usr/share/doc || die "cd failed"
	mv ${PN}/${PN}.pdf ${PF}/ || die "mv failed"
	rm -rf ${PN}/ || die "rm failed"
}
