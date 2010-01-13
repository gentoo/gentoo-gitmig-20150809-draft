# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qd/qd-2.3.9.ebuild,v 1.1 2010/01/13 17:19:06 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="Quad-double and double-double float arithmetics"
IUSE="fortran"
HOMEPAGE="http://crd.lbl.gov/~dhbailey/mpdist/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_URI="http://crd.lbl.gov/~dhbailey/mpdist/${P}.tar.gz"

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.3.7-test.patch
}

src_configure() {
	econf $(use_enable fortran enable_fortran)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS NEWS TODO || die "dodoc failed"
	cd "${D}"/usr/share/doc || die "cd failed"
	mv ${PN}/${PN}.pdf ${PF}/ || die "mv failed"
	rm -rf ${PN}/ || die "rm failed"
}
