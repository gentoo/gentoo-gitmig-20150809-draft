# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ldap_userdir/mod_ldap_userdir-1.1.4-r1.ebuild,v 1.1 2005/01/09 00:32:44 hollow Exp $

inherit apache-module

IUSE="ssl"
DESCRIPTION="Apache module that enables ~/public_html from an LDAP directory."
HOMEPAGE="http://horde.net/~jwm/software/mod_ldap_userdir/"
KEYWORDS="~x86 ~ppc"

S=${WORKDIR}/${P}
SRC_URI="http://horde.net/~jwm/software/mod_ldap_userdir/${P}.tar.gz"

DEPEND="ssl? (dev-libs/openssl)
		net-nds/openldap"
LICENSE="GPL-1"
SLOT="0"

APXS1_S="${S}"
APXS2_S="${S}"

APACHE1_MOD_FILE="${S}/mod_ldap_userdir.so"
APACHE2_MOD_FILE="${S}/mod_ldap_userdir.so"

DOCFILES="DIRECTIVES README user-ldif posixAccount-objectclass"
APACHE1_MOD_CONF="${PVR}/47_mod_ldap_userdir"
APACHE2_MOD_CONF="${PVR}/47_mod_ldap_userdir"

need_apache

src_compile() {
	local myargs="-lldap -llber -c ${PN}.c"
	useq ssl && myargs="${myargs} -D TLS=1"

	if useq apache2; then
		APXS2_ARGS="${myargs}"
	else
		APXS1_ARGS="${myargs}"
	fi

	apache_dual_src_compile
}
