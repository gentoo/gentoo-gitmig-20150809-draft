# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pymsn-t/pymsn-t-0.9.2.ebuild,v 1.1 2005/04/18 11:35:36 humpback Exp $

# Based on net-im/pyicq-t ebuild by Karl-Johan Karlsson
inherit eutils

MY_PN="PyMSNt"
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="MSN transport for Jabber"
HOMEPAGE="http://msn-transport.jabberstudio.org/"
SRC_URI="http://msn-transport.jabberstudio.org/downloads/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-2.3"
RDEPEND="virtual/jabber-server
		>=dev-python/twisted-1.1
		<dev-python/twisted-2"
IUSE=""

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-arguments.patch
}

src_install()
{
	enewgroup jabber
	enewuser pymsn-t -1 /bin/false /var/run/pymsn-t jabber

	insinto /usr/lib/${PN}/src
	doins src/*

	dodir /var/log/pymsn-t

	exeinto /usr/lib/${PN}
	newexe PyMSNt pymsn-t

	insinto /etc
	newins config-example.xml pymsn-t.xml

	exeinto /etc/init.d
	newexe ${FILESDIR}/pymsn-t.initd pymsn-t

	dodir /var/spool/${PN}
	fowners pymsn-t:jabber /var/spool/${PN}

	dodir /var/log/${PN}
	fowners pymsn-t:jabber /var/log/${PN}

	dodir /var/run/${PN}
	fowners pymsn-t:jabber /var/run/${PN}
}

pkg_postinst() {
	einfo "A sample configuration file has been installed in /etc/pymsn-t.xml."
	einfo "Please edit it, and the configuration of you Jabber server to match."
	einfo "You also need to create a directory msn.yourdomain.com in"
	einfo "/var/spool/pymsn-t/ and chown it to pymsn-t:jabber."
}
