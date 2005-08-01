# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/re2c/re2c-0.9.9.ebuild,v 1.1 2005/08/01 04:31:14 robbat2 Exp $

inherit eutils

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="|| ( >=dev-util/byacc-1.9 >=sys-devel/bison-2.0 )
		${RDEPEND}"

src_unpack() {
	unpack ${A} || die
	# Fix permissions
	chmod -R u+rw ${S}
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
