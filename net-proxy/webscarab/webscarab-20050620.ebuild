# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/webscarab/webscarab-20050620.ebuild,v 1.2 2005/07/31 11:20:27 dholm Exp $

DESCRIPTION="A framework for analysing applications that communicate using the HTTP and HTTPS protocols"
HOMEPAGE="http://www.owasp.org/software/webscarab.html"
SRC_URI="mirror://sourceforge/owasp/${PN}-selfcontained-${PV}-1046.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	einfo "Nothing to unpack"
}

src_install() {
	newbin ${FILESDIR}/${PN}.sh ${PN}
	insinto /usr/lib
	newins ${DISTDIR}/${A} ${PN}.jar
}
