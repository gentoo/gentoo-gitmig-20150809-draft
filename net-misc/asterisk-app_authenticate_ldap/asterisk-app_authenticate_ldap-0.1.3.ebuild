# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_authenticate_ldap/asterisk-app_authenticate_ldap-0.1.3.ebuild,v 1.1 2005/08/27 22:25:39 stkn Exp $

inherit eutils

MY_PN="app_authenticate_ldap"

DESCRIPTION="Asterisk application plugin for authentication using LDAP"
HOMEPAGE="http://www.ionidea.ua/oss/asterisk/"
SRC_URI="http://www.ionidea.ua/oss/asterisk/${MY_PN}-${PV}.tar.gz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

# depends on iconv support
DEPEND="sys-libs/glibc
	>=net-misc/asterisk-1.0.7-r1
	net-misc/asterisk-app_ldap"

S=${WORKDIR}/apps

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-0.1.3-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README.Authenticate_LDAP
}
