# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemimager-client-bin/systemimager-client-bin-3.0.1.ebuild,v 1.5 2004/02/29 15:27:12 aliz Exp $

MY_P="systemimager-client-3.0.1-4.noarch"

S=${WORKDIR}
DESCRIPTION="System imager client. Software that automates Linux installs, software distribution, and production deployment."
HOMEPAGE="http://www.systemimager.org/"
SRC_URI="mirror://sourceforge/systemimager/${MY_P}.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="app-arch/rpm2targz
	app-admin/systemimager-common-bin"
RDEPEND="${DEPEND}
		dev-perl/AppConfig
		app-admin/systemconfigurator"

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_compile() {
	einfo "nothing to compile; binary package."
}

src_install() {

#stuff in /usr
	dosbin usr/sbin/{prepareclient,updateclient}
	doman usr/share/man/man8/*.gz
	dodoc usr/share/doc/systemimager-client-3.0.1/*

#stuff in etc
	mkdir -p ${D}/etc/system/imager
	insinto /etc/systemimager
	doins	etc/systemimager/{client.conf,updateclient.local.exclude}

}

