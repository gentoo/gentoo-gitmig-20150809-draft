# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ldl/ldl-2.0.3.ebuild,v 1.1 2011/02/23 20:05:08 bicatali Exp $

EAPI=2
inherit autotools eutils

MY_PN=LDL
DESCRIPTION="Simple but educational LDL^T matrix factorization algorithm"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/ldl"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"
DEPEND="sci-libs/ufconfig"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.1-autotools.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Doc/ldl_userguide.pdf || die
	fi
}
