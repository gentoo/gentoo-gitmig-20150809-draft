# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/csparse/csparse-2.2.3.ebuild,v 1.1 2009/11/21 07:15:59 bicatali Exp $

EAPI=2
inherit autotools eutils

MY_PN=CSparse
DESCRIPTION="Concise sparse matrix package."
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/CSparse"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${MY_PN}/versions/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2.2-autotools.patch
	eautoreconf
}

src_configure() {
	# avoid collision with cxsparse
	econf --includedir="/usr/include/csparse"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
}
