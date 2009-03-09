# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/csparse/csparse-2.2.1-r1.ebuild,v 1.1 2009/03/09 16:45:31 bicatali Exp $

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

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_compile() {
	# avoid collision with cxsparse
	econf --includedir="/usr/include/csparse"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
}
