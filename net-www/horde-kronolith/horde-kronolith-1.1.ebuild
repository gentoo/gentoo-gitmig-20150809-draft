# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-kronolith/horde-kronolith-1.1.ebuild,v 1.1 2003/05/12 18:39:34 alron Exp $

DESCRIPTION="Kronolith ${PV} is the Horde calendar application"
HOMEPAGE="http://www.horde.org"
P=kronolith-1.1
SRC_URI="ftp://ftp.horde.org/pub/kronolith/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=net-www/horde-2.2.1"
IUSE=""

find_http_root() {
	export HTTPD_ROOT=`grep apache /etc/passwd | cut -d: -f6`/htdocs
	if [ -z "${HTTPD_ROOT}" ]; then
		eerror "HTTPD_ROOT is null! Using defaults."
		eerror "You probably want to check /etc/passwd"
		HTTPD_ROOT="/home/httpd/htdocs"
	fi

	export REGISTRY=${HTTPD_ROOT}/horde/config/registry.php
	[ -f ${REGISTRY} ] || REGISTRY=${HTTPD_ROOT}/horde/config/registry.php.dist
}

pkg_setup() {
	GREPSQL=`grep sql /var/db/pkg/dev-php/mod_php*/USE`
	GREPLDAP=`grep ldap /var/db/pkg/dev-php/mod_php*/USE`
	if [ "${GREPSQL}" != "" ] || [ "${GREPLDAP}" != "" ] ; then
		return 0
	else
		eerror "Missing SQL or LDAP support in mod_php !"
		die "aborting..."
	fi
	find_http_root
	[ -f ${REGISTRY} ] || die "${REGISTRY} not found"
}

src_compile() {
	echo "Nothing to compile"
}

src_install () {

	# detecting apache usergroup
	GID=`grep apache /etc/group |cut -d: -f3`
	if [ -z "${GID}" ]; then
		einfo "Using default GID of 81 for Apache"
		GID=81
	fi

	find_http_root
	dodir ${HTTPD_ROOT}/horde/kronolith
	cp -r . ${D}/${HTTPD_ROOT}/horde/kronolith

	# protecting files
	chown -R apache.${GID} ${D}/${HTTPD_ROOT}/horde/kronolith
	find ${D}/${HTTPD_ROOT}/horde/kronolith/ -type f -exec chmod 0640 {} \;
	find ${D}/${HTTPD_ROOT}/horde/kronolith/ -type d -exec chmod 0750 {} \;
}

pkg_postinst() {
	find_http_root
	einfo "Please read ${HTTPD_ROOT}/horde/kronolith/docs/INSTALL !"
}
