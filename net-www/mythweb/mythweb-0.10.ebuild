# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mythweb/mythweb-0.10.ebuild,v 1.3 2004/03/23 18:57:36 mholzer Exp $

IUSE="apache2"
DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="dev-db/mysql
	dev-php/mod_php"

src_install() {

	HTTPD_USER="apache"
	HTTPD_GROUP="apache"

	if [ ! -z "`use apache2`" -a -e "/etc/apache2/conf/apache2.conf" ] ; then
		HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache2/conf/apache2.conf | cut -d' '  -f2`"
	elif [ -e "/etc/apache/conf/apache.conf" ] ; then
		HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d' ' -f2`"
	else
		HTTPD_ROOT="/home/httpd/htdocs"
		ewarn
		ewarn "No apache config file found in /etc, assuming DocumentRoot /home/httpd/htdocs"
		ewarn
	fi

	dodoc README

	dodir "${HTTPD_ROOT}"
	cp -R "${S}" "${D}/${HTTPD_ROOT}/${PN}"

}

pkg_postinst() {

	einfo "You should modify ${HTTPD_ROOT}/${PN}/settings.php"
	einfo "to fit your needs."
	echo

}
