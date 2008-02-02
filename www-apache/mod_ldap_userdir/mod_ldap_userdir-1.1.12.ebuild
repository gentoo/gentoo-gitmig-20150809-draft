# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_ldap_userdir/mod_ldap_userdir-1.1.12.ebuild,v 1.1 2008/02/02 10:44:36 hollow Exp $

inherit apache-module

DESCRIPTION="Apache module that enables ~/public_html from an LDAP directory."
HOMEPAGE="http://horde.net/~jwm/software/mod_ldap_userdir/"
SRC_URI="http://horde.net/~jwm/software/mod_ldap_userdir/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )
		net-nds/openldap"
RDEPEND="${DEPEND}"

DOCFILES="DIRECTIVES README user-ldif posixAccount-objectclass"

APXS2_ARGS="-lldap -llber -c ${PN}.c"
APACHE2_MOD_CONF="47_mod_ldap_userdir"
APACHE2_MOD_DEFINE="LDAP_USERDIR"

need_apache2_2

src_compile() {
	econf || die "econf failed"
	use ssl && APXS2_ARGS="${APXS2_ARGS} -DTLS=1"
	apache-module_src_compile
}

src_install() {
	apache-module_src_install
	fperms 600 "${APACHE_MODULES_CONFDIR}"/47_mod_ldap_userdir.conf
}
