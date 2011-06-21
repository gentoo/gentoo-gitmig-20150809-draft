# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/arprec/arprec-2.2.2.ebuild,v 1.5 2011/06/21 15:42:20 jlec Exp $

EAPI=2

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

src_prepare() {
	# bug #273996
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_configure() {
	econf \
		$(use_enable fortran enable_fortran) \
		$(use_enable qd enable_qd)
}

src_compile() {
	emake || die "emake failed"
	if use fortran; then
		emake toolkit || die "emake toolkit failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS NEWS TODO || die "dodoc failed"
	if use fortran; then
		cd toolkit
		./mathinit || die "mathinit failed"
		exeinto /usr/libexec/${PN}
		doexe mathtool || die "mathtool install failed"
		insinto /usr/libexec/${PN}
		doins *.dat || die "mathtool data install failed"
		docinto toolkit
		dodoc README || die "mathtool doc install failed"
	fi
	cd "${D}"/usr/share/doc || die "cd failed"
	mv ${PN}/${PN}.pdf ${PF}/ || die "mv failed"
	rm -rf ${PN}/ || die "rm failed"
}
