# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.6.8a.ebuild,v 1.8 2003/06/13 20:06:19 vapier Exp $

inherit eutils

DESCRIPTION="Cacti is a complete frondend to rrdtool"
HOMEPAGE="http://www.raxnet.net/products/cacti/"
SRC_URI="http://www.raxnet.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="snmp"

DEPEND=""
RDEPEND="net-www/apache
	snmp? ( net-analyzer/ucd-snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	dev-php/php
	dev-php/mod_php"

export HTTPD_ROOT=/home/httpd/htdocs
export HTTPD_USER=apache
export HTTPD_GROUP=apache
export INSTALL_DEST=${HTTPD_ROOT}/cacti

src_install() {
	dodoc docs/{CHANGELOG,CONTRIB,README}
	rm README LICENSE docs/{CHANGELOG,CONTRIB,README}

	dodir ${INSTALL_DEST}
	edos2unix `find -type f -name '*.php'`
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} *
	mv * ${D}/${INSTALL_DEST}/
}

pkg_postinst() {
	einfo
	einfo "The cacti has been copied to ${INSTALL_DEST}"
	einfo
	einfo "Before cacti works you must create the cacti database:"
	einfo " mysqladmin -u root -p create cacti"
	einfo " mysql -u root -p cacti < ${INSTALL_DEST}/cacti.sql"
	einfo "And you must setup the config.php file:"
	einfo " nano ${INSTALL_DEST}/include/config.php"
	einfo
	einfo "FINALLY, you must have these settings in your php.ini:"
	einfo " register_globals = On"
	einfo " register_argc_argv = On"
	einfo
}
