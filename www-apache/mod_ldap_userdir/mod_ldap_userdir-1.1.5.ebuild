# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_ldap_userdir/mod_ldap_userdir-1.1.5.ebuild,v 1.3 2008/01/29 16:37:24 hollow Exp $

inherit apache-module

KEYWORDS="ppc x86"

DESCRIPTION="Apache module that enables ~/public_html from an LDAP directory."
HOMEPAGE="http://horde.net/~jwm/software/mod_ldap_userdir/"
SRC_URI="http://horde.net/~jwm/software/mod_ldap_userdir/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )
		net-nds/openldap"
RDEPEND="${DEPEND}"

DOCFILES="DIRECTIVES README user-ldif posixAccount-objectclass"

APACHE2_MOD_CONF="47_mod_ldap_userdir"
APACHE2_MOD_DEFINE="LDAP_USERDIR"

need_apache

src_compile() {
	local myargs="-lldap -llber"
	use ssl && myargs="${myargs} -DTLS=1"
	myargs="${myargs} -c ${PN}.c"

	APXS2_ARGS="${myargs}"

	apache-module_src_compile
}

src_install() {
	apache-module_src_install
	fperms 600 "${APACHE_MODULES_CONFDIR}"/$(basename ${APACHE2_MOD_CONF}).conf
}
