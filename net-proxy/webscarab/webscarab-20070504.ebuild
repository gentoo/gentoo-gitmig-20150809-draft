# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/webscarab/webscarab-20070504.ebuild,v 1.3 2007/09/15 11:21:55 angelos Exp $

DESCRIPTION="A framework for analysing applications that communicate using the HTTP and HTTPS protocols"
HOMEPAGE="http://www.owasp.org/software/webscarab.html"
SRC_URI="mirror://sourceforge/owasp/${PN}-selfcontained-${PV}-1631.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"

src_unpack() {
	einfo "Nothing to unpack"
}

src_install() {
	newbin "${FILESDIR}/${PN}.sh" "${PN}"
	insinto /usr/lib
	newins "${DISTDIR}/${A}" "${PN}.jar"
}
