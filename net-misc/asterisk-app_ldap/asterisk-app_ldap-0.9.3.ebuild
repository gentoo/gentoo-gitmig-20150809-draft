# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_ldap/asterisk-app_ldap-0.9.3.ebuild,v 1.1 2005/02/15 20:30:35 stkn Exp $

inherit eutils

MY_PN="app_ldap"

DESCRIPTION="Asterisk application plugin to do lookups in a LDAP directory"
HOMEPAGE="http://www.mezzo.net/asterisk/"
SRC_URI="http://www.mezzo.net/asterisk/${MY_PN}-${PV}.tgz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

# depends on iconv support
DEPEND="sys-libs/glibc
	>=net-nds/openldap-2.0.0
	>=net-misc/asterisk-1.0.5-r1"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-${PV}-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README ldap.conf
}
