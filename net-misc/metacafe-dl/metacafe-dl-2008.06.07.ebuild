# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/metacafe-dl/metacafe-dl-2008.06.07.ebuild,v 1.1 2008/06/12 15:06:31 agorf Exp $

DESCRIPTION="A small command-line program to download videos from Metacafe."
HOMEPAGE="http://www.arrakis.es/~rggi3/metacafe-dl/"
SRC_URI="http://www.arrakis.es/~rggi3/${PN}/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_unpack() {
	:
}

src_install() {
	newbin "${DISTDIR}/${P}" ${PN}
}
