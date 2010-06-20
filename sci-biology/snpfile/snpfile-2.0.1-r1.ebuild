# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/snpfile/snpfile-2.0.1-r1.ebuild,v 1.1 2010/06/20 16:58:42 xarthisius Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A library and API for manipulating large SNP datasets"
HOMEPAGE="http://www.birc.au.dk/~mailund/SNPFile/"
SRC_URI="http://www.birc.au.dk/~mailund/SNPFile/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="static-libs"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-gentoo.diff
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README NEWS || die
}
