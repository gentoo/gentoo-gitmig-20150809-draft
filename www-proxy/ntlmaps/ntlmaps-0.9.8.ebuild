# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/ntlmaps/ntlmaps-0.9.8.ebuild,v 1.1 2004/08/15 18:55:44 stuart Exp $

inherit eutils

DESCRIPTION="NTLM proxy. Authentication against MS proxy/web server written in python"
HOMEPAGE="http://ntlmaps.sourceforge.net/"
MY_P_URL=`echo ${P} | sed -e 's|ntlmaps|aps|;s|-||g;s|\.||g'`
S=${WORKDIR}/${MY_P_URL}
SRC_URI="mirror://sourceforge/ntlmaps/${MY_P_URL}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND=">=dev-lang/python-1.5"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_install() {
	cd ${S}
	dodir /usr/${PN}/lib
	exeinto /usr/${PN}
	doexe main.py
	insinto /usr/${PN}/lib
	doins lib/*

	dodoc COPYING Install.txt changelog.txt readme.txt research.txt
	insinto /usr/share/doc/${P}/doc
	doins doc/*

	insinto /etc/conf.d
	newins ${S}/server.cfg ${PN}.cfg
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}.init ${PN}
}
