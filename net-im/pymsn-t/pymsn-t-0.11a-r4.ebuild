# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pymsn-t/pymsn-t-0.11a-r4.ebuild,v 1.3 2006/04/06 19:53:18 swegener Exp $

inherit eutils python

MY_PN="pymsnt"
S=${WORKDIR}/${MY_PN}-${PV/a/}
DESCRIPTION="New Python based jabber transport for MSN"
HOMEPAGE="http://msn-transport.jabberstudio.org/"
SRC_URI="http://msn-transport.jabberstudio.org/tarballs/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=net-im/jabber-base-0.0
	>=dev-lang/python-2.3"

RDEPEND=">=dev-python/twisted-1.3.0
	>=dev-python/twisted-words-0.1.0
	>=dev-python/twisted-xish-0.1.0
	>=dev-python/twisted-web-0.5.0
	>=dev-python/nevow-0.4.1
	>=dev-python/imaging-1.1"
IUSE=""

src_unpack() {
	unpack ${A}
	find -name ".svn" -type d -exec rm -rf {} \; &> /dev/null
}

src_install() {
	python_version
	einfo ${PWD}
	insinto /usr/lib/python${PYVER}/site-packages/${PN}
	doins -r data src
	newins PyMSNt.py pymsn-t.py

	insinto /etc/jabber
	newins config-example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	dosed \
		"s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber/</spooldir>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<host>[^\<]*</host>:<host>example.org</host>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<jid>[^\<]*</jid>:<jid>msn.example.org</jid>:" \
		/etc/jabber/${PN}.xml

	exeinto /etc/init.d
	newexe ${FILESDIR}/pymsn-t.initd pymsn-t
	dosed "s/PATH/python${PYVER}/" /etc/init.d/pymsn-t
}

pkg_postinst() {
	einfo "A sample configuration file has been installed in /etc/jabber/pymsn-t.xml."
	einfo "Please edit it, and the configuration of you Jabber server to match."
	einfo "You also need to create a directory msn.yourdomain.com in"
	einfo "/var/spool/jabber/ and chown it to jabber:jabber."
}
