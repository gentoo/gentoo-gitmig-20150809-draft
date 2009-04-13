# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qd/qd-2.3.7.ebuild,v 1.2 2009/04/13 21:03:53 grozin Exp $
EAPI=2
inherit eutils
DESCRIPTION="Quad-double and double-double float arithmetics"
IUSE="fortran"
HOMEPAGE="http://crd.lbl.gov/~dhbailey/mpdist/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

SRC_URI="http://crd.lbl.gov/~dhbailey/mpdist/${P}.tar.gz"

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-test.patch
}

src_configure() {
	econf $(use_enable fortran enable_fortran)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS NEWS TODO || die "dodoc failed"
	cd "${D}"/usr/share/doc || die "cd failed"
	mv ${PN}/${PN}.pdf ${PF}/ || die "mv failed"
	rm -rf ${PN}/ || die "rm failed"
}
