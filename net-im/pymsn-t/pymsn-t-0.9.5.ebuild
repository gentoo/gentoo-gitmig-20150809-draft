# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pymsn-t/pymsn-t-0.9.5.ebuild,v 1.1 2005/08/28 16:13:36 humpback Exp $

inherit eutils python

MY_PN="PyMSNt"
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="MSN transport for Jabber"
HOMEPAGE="http://msn-transport.jabberstudio.org/"
SRC_URI="http://msn-transport.jabberstudio.org/tarballs/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=net-im/jabber-base-0.0
		>=dev-lang/python-2.3"
RDEPEND="virtual/jabber-server
		>=dev-python/twisted-2
		dev-python/twisted-words
		dev-python/twisted-xish
		dev-python/twisted-web"
IUSE=""

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.9.5-arguments.patch
	rm -rf src/CVS
	rm -rf src/baseproto/CVS
	rm -rf src/legacy/CVS
	rm -rf src/tlib/CVS
	rm -rf src/tlib/jabber/CVS
}

src_install()
{
	python_version
	#Dont like this, have to find way to do recursive copy with doins
	dodir /usr/lib/python${PYVER}/site-packages/${PN}/src
	cp -r src/* ${D}/usr/lib/python${PYVER}/site-packages/${PN}/src


	exeinto /usr/lib/python${PYVER}/site-packages/
	doexe PyMSNt
	sed -i \
		-e "s/.*<spooldir>.*/<spooldir>\/var\/spool\/jabber\/${PN}<\/spooldir>/"                                \
		-e "s/.*<pid>.*/<pid>\/var\/run\/jabber\/pymsn-t.pid<\/pid>/"                                    \
		-e "s/.*<debugLog>.*/<debugLog>\/var\/log\/jabber\/${PN}-debug.log<\/debugLog>/"       \
			config-example.xml
	insinto /etc/jabber
	newins config-example.xml pymsn-t.xml

	exeinto /etc/init.d
	newexe ${FILESDIR}/pymsn-t.initd pymsn-t
	sed -i -e "s/PATH/python${PYVER}/" ${D}/etc/init.d/pymsn-t
}

pkg_postinst() {
	einfo "A sample configuration file has been installed in /etc/jabber/pymsn-t.xml."
	einfo "Please edit it, and the configuration of you Jabber server to match."
	einfo "You also need to create a directory msn.yourdomain.com in"
	einfo "/var/spool/jabber/ and chown it to jabber:jabber."
}
