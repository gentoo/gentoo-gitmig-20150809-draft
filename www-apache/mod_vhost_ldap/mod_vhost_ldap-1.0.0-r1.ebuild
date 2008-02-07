# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_vhost_ldap/mod_vhost_ldap-1.0.0-r1.ebuild,v 1.2 2008/02/07 22:22:16 hollow Exp $

inherit eutils apache-module

KEYWORDS="~amd64 ~x86"

DESCRIPTION="An Apache2 module for storing and configuring virtual hosts from LDAP."
HOMEPAGE="http://alioth.debian.org/projects/modvhostldap/"
SRC_URI="http://alioth.debian.org/download.php/1422/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

APACHE2_MOD_CONF="99_${PN}"
APACHE2_MOD_DEFINE="VHOST_LDAP LDAP"

DOCFILES="AUTHORS ChangeLog INSTALL README"

need_apache2_2

S="${WORKDIR}/mod-vhost-ldap-${PV}"

pkg_setup() {
	if ! built_with_use www-servers/apache ldap ; then
		eerror
		eerror "Apache2 needs to be built with ldap support to get this module working!"
		eerror
		die "Apache2 lacks ldap support"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-apache22.patch
}

src_compile() {
	sed -i "s/MOD_VHOST_LDAP_VERSION/\"$(cat VERSION)\"/g" mod_vhost_ldap.c
	apache-module_src_compile
}

src_install() {
	mkdir -p "${D}"/etc/openldap/schema
	cp -f mod_vhost_ldap.schema "${D}"/etc/openldap/schema/
	apache-module_src_install
}

pkg_postinst() {
	apache-module_pkg_postinst
	einfo
	einfo "Your LDAP server needs to include mod_vhost_ldap.schema and should"
	einfo "also maintain indices on apacheServerName and apacheServerAlias."
	einfo
}
