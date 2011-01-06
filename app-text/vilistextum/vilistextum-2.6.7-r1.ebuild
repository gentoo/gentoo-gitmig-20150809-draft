# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vilistextum/vilistextum-2.6.7-r1.ebuild,v 1.2 2011/01/06 16:31:26 jlec Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Html to ascii converter specifically programmed to get the best out of incorrect html"
HOMEPAGE="http://bhaak.dyndns.org/vilistextum/"
SRC_URI="http://bhaak.dyndns.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
#IUSE="unicode kde"
IUSE="unicode"

DEPEND="virtual/libiconv"
RDEPEND=""
# KDE support will be available once a version of kaptain in stable
#	 kde? ( kde-misc/kaptain )"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-gentoo.diff" \
		"${FILESDIR}/${P}-use-glibc-iconv.diff"

	eautoreconf
}

src_configure() {
	econf $(use_enable unicode multibyte)
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README CHANGES || die
	dohtml doc/*.html || die
}
