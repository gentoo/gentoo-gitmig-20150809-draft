# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_ldap/asterisk-app_ldap-1.0_rc5.ebuild,v 1.1 2005/12/05 17:18:37 stkn Exp $

inherit eutils

MY_PN="app_ldap"

DESCRIPTION="Asterisk application plugin to do lookups in a LDAP directory"
HOMEPAGE="http://www.mezzo.net/asterisk/"
SRC_URI="http://www.mezzo.net/asterisk/${MY_PN}-${PV/_/}.tgz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

# depends on iconv support
DEPEND="sys-libs/glibc
	>=net-nds/openldap-2.0.0
	>=net-misc/asterisk-1.0.7-r1"

S=${WORKDIR}/${MY_PN}-${PV/_/}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-1.0_rc5-gentoo.diff
}

src_compile() {
	emake -j1 clean all || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc CHANGES README ldap.conf.sample

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		chown -R root:asterisk ${D}etc/asterisk
		chmod -R u=rwX,g=rX,o= ${D}etc/asterisk
	fi
}
