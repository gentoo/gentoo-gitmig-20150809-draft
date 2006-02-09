# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_vhost_ldap/mod_vhost_ldap-1.0.ebuild,v 1.1 2006/02/09 21:22:18 jokey Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 DSO for storing and configuring virtual hosts from LDAP"
HOMEPAGE="http://alioth.debian.org/projects/modvhostldap/"
SRC_URI="http://alioth.debian.org/download.php/1192/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}

SRCDIR="${S}/mod-vhost-ldap-${PV}"
APXS2_S="${SRCDIR}"
APACHE2_MOD_CONF="99_${PN}"
APACHE2_MOD_DEFINE="VHOST_LDAP"

DOCFILES="${SRCDIR}/AUTHORS ${SRCDIR}/ChangeLog ${SRCDIR}/INSTALL ${SRCDIR}/README"

need_apache2

pkg_setup () {
	if ! built_with_use net-www/apache ldap ; then
		eerror
		eerror "Apache needs to be built with ldap support to get this module working"
		eerror
		die "Apache lacks ldap support"
	fi
}

src_unpack () {
	unpack ${A}
	#rename crappy dir versioning
	mv ${S}/mod-vhost-ldap-0.2.9 ${SRCDIR}
}

src_compile () {
	cd ${APXS2_S}
	sed -i s/MOD_VHOST_LDAP_VERSION/\"`cat VERSION`\"/g mod_vhost_ldap.c
	apache-module_src_compile
}

src_install () {
	mkdir -p ${D}/etc/openldap/schema
	cp ${SRCDIR}/mod_vhost_ldap.schema ${D}/etc/openldap/schema
	apache-module_src_install
}

pkg_postinst () {
	einfo
	einfo "To enable ${PN}, you need to edit your /etc/conf.d/apache2 file and"
	einfo "add '-D ${APACHE2_MOD_DEFINE}' to APACHE2_OPTS."
	einfo
	einfo "Configuration file installed as"
	einfo "    ${APACHE2_MODULES_CONFDIR}/$(basename ${APACHE2_MOD_CONF}).conf"
	einfo
	einfo "Your LDAP server needs to include mod_vhost_ldap.schema and should"
	einfo "also maintain indices on apacheServerName and apacheServerAlias"
	einfo
}
