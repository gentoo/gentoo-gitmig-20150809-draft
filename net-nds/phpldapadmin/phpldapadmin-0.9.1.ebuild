# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Don Seiler <rizzo@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/phpldapadmin/phpldapadmin-0.9.1.ebuild,v 1.1 2003/11/13 21:05:34 rizzo Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="phpLDAPadmin is a web-based tool for managing all aspects of your LDAP server."
HOMEPAGE="http://phpldapadmin.sourceforge.net"
SRC_URI="mirror://sourceforge/phpldapadmin/${PN}-${PV}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/php"

inherit webapp-apache
webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	# Check for "ldap" in USE vars for mod_php
	webapp-check-php ldap

	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_install() {
	dodir "${HTTPD_ROOT}/phpldapadmin"
	cp -a * "${D}/${HTTPD_ROOT}/phpldapadmin"
	dodoc INSTALL LICENSE VERSION

	chown -R "${HTTPD_USER}.${HTTPD_GROUP}" "${D}/${HTTPD_ROOT}/phpldapadmin"
	chmod 0775 "${D}/${HTTPD_ROOT}/phpldapadmin"
}

pkg_postinst() {
	einfo
	einfo "phpLDAPadmin is installed.  You will need to"
	einfo "configure it by creating/editing the config.php"
	einfo "at:"
	einfo
	einfo "${HTTPD_ROOT}/phpldapadmin/config.php"
	einfo
	einfo "There is a config.php.example for your reference."
	einfo
}
