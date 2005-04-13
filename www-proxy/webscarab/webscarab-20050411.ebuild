# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/webscarab/webscarab-20050411.ebuild,v 1.1 2005/04/13 21:23:31 mrness Exp $

DESCRIPTION="A framework for analysing applications that communicate using the HTTP and HTTPS protocols"
HOMEPAGE="http://www.owasp.org/software/webscarab.html"
SRC_URI="mirror://sourceforge/owasp/${PN}-selfcontained-${PV}-1640.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
