# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/re2c/re2c-0.9.11.ebuild,v 1.2 2006/04/22 05:58:12 halcy0n Exp $

inherit eutils

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.sourceforge.net/"
MY_PV="${PV/_/.}"
MY_P="${PN}-${MY_PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="|| ( >=dev-util/byacc-1.9 >=sys-devel/bison-2.0 )
		${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A} || die
	# Fix permissions
	chmod -R u+rw ${S}
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	econf || die
	emake -e || die
}

src_install() {
	dobin re2c || die "dobin failed"
	doman re2c.1 || die "doman failed"
	dodoc README CHANGELOG doc/* && \
	docinto examples && \
	dodoc examples/*.c examples/*.re || die "docs failed"
}
