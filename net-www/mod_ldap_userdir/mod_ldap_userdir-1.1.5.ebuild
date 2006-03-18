# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ldap_userdir/mod_ldap_userdir-1.1.5.ebuild,v 1.4 2006/03/18 11:18:20 kloeri Exp $

inherit apache-module

IUSE="apache2 ssl"
DESCRIPTION="Apache module that enables ~/public_html from an LDAP directory."
HOMEPAGE="http://horde.net/~jwm/software/mod_ldap_userdir/"
KEYWORDS="ppc x86"

SRC_URI="http://horde.net/~jwm/software/mod_ldap_userdir/${P}.tar.gz"

DEPEND="ssl? ( dev-libs/openssl )
		net-nds/openldap"
LICENSE="GPL-1"
SLOT="0"

DOCFILES="DIRECTIVES README user-ldif posixAccount-objectclass"

APACHE1_MOD_CONF="1.1.4-r1/47_mod_ldap_userdir"
APACHE1_MOD_DEFINE="LDAP_USERDIR"

APACHE2_MOD_CONF="1.1.4-r1/47_mod_ldap_userdir"
APACHE2_MOD_DEFINE="LDAP_USERDIR"

need_apache

src_compile() {
	local myargs="-lldap -llber"
	useq ssl && myargs="${myargs} -DTLS=1"
	myargs="${myargs} -c ${PN}.c"

	if useq apache2; then
		APXS2_ARGS="${myargs}"
	else
		APXS1_ARGS="${myargs}"
	fi

	apache-module_src_compile
}

src_install() {
	apache-module_src_install
	useq apache2 && fperms 600 ${APACHE2_MODULES_CONFDIR}/$(basename ${APACHE2_MOD_CONF}).conf
	useq apache2 || fperms 600 ${APACHE1_MODULES_CONFDIR}/$(basename ${APACHE1_MOD_CONF}).conf
}
