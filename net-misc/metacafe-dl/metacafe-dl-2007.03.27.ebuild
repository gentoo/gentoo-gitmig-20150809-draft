# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/metacafe-dl/metacafe-dl-2007.03.27.ebuild,v 1.6 2007/08/11 19:15:55 corsair Exp $

DESCRIPTION="A small command-line program to download videos from Metacafe."
HOMEPAGE="http://www.arrakis.es/~rggi3/metacafe-dl/"
SRC_URI="http://www.arrakis.es/~rggi3/${PN}/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_unpack() {
	:
}

src_install() {
	dobin "${DISTDIR}/${P}"
	dosym "${P}" "/usr/bin/${PN}"
}
