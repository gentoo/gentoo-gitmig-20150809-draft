# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/ntlmaps/ntlmaps-0.9.8.ebuild,v 1.2 2004/09/23 12:25:30 vapier Exp $

inherit eutils

MY_P_URL="aps${PV//.}"
DESCRIPTION="NTLM proxy Authentication against MS proxy/web server"
HOMEPAGE="http://ntlmaps.sourceforge.net/"
SRC_URI="mirror://sourceforge/ntlmaps/${MY_P_URL}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-1.5"

S=${WORKDIR}/${MY_P_URL}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_install() {
	dodir /usr/${PN}/lib
	exeinto /usr/${PN}
	doexe main.py || die
	insinto /usr/${PN}/lib
	doins lib/*

	dodoc Install.txt changelog.txt readme.txt research.txt
	insinto /usr/share/doc/${P}/doc
	doins doc/*

	insinto /etc/conf.d
	newins ${S}/server.cfg ${PN}.cfg
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}.init ${PN}
}
