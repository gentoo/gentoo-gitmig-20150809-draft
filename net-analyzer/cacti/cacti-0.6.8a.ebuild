# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.6.8a.ebuild,v 1.7 2003/05/13 19:15:25 mholzer Exp $

DESCRIPTION="Cacti is a complete frondend to rrdtool"
HOMEPAGE="http://www.raxnet.net/products/cacti/"
SRC_URI="http://www.raxnet.net/downloads/${P}.tar.gz"

IUSE="snmp"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=""
RDEPEND="net-www/apache
	snmp? ( net-analyzer/ucd-snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	dev-php/php
	dev-php/mod_php"

INSTALL_DEST="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`"
[ -z "${INSTALL_DEST}" ] && INSTALL_DEST="/home/httpd/htdocs"
INSTALL_DEST="${INSTALL_DEST}/cacti"

src_install() {
	dodoc docs/{CHANGELOG,CONTRIB,README}
	rm README LICENSE docs/{CHANGELOG,CONTRIB,README}

	dodir ${INSTALL_DEST}
	chown apache.apache * -R
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
