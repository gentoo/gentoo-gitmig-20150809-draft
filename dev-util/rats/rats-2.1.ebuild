# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rats/rats-2.1.ebuild,v 1.12 2009/09/23 17:47:08 patrick Exp $

DESCRIPTION="RATS - Rough Auditing Tool for Security"
HOMEPAGE="http://www.fortifysoftware.com/security-resources/rats.jsp"
SRC_URI="http://www.fortifysoftware.com/servlet/downloads/public/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND="dev-libs/expat"

src_compile() {
	econf --datadir="/usr/share/${PN}/" || die
	emake || die
}

src_install () {
	einstall SHAREDIR="${D}/usr/share/${PN}" MANDIR="${D}/usr/share/man" || die
	dodoc README README.win32 COPYING
}
