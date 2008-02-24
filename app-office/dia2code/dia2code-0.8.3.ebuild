# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia2code/dia2code-0.8.3.ebuild,v 1.1 2008/02/24 10:31:25 eva Exp $

inherit flag-o-matic

DESCRIPTION="Convert UML diagrams produced with Dia to various source code flavours."
HOMEPAGE="http://dia2code.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/libxml2"
RDEPEND="${DEPEND}
	>=app-office/dia-0.90.0"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
	doman dia2code.1
}
