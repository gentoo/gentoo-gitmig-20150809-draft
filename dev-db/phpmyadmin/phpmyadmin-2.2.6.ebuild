# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.2.6.ebuild,v 1.4 2002/07/16 08:41:59 rphillips Exp $

MY_PN=phpMyAdmin

S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Web-based administration for MySQL database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-php.tar.bz2"
HOMEPAGE="http://phpmyadmin.sourceforge.net/"
LICENSE="GPL-2"

DEPEND=">=net-www/apache-1.3.24-r1 >=dev-db/mysql-3.23.38 >=dev-php/mod_php-4.1.2-r5"

src_compile() { :; }

src_install () {
	insinto /home/httpd/htdocs/phpmyadmin
	doins *.{php,html}

	insinto /home/httpd/htdocs/phpmyadmin/images
	doins images/*.{gif,png}

	insinto /home/httpd/htdocs/phpmyadmin/scripts
	doins scripts/*.sh

	insinto /home/httpd/htdocs/phpmyadmin/lang
	doins lang/*.{php,sh}

	insinto /home/httpd/htdocs/phpmyadmin/libraries
	doins libraries/*.{php,js}

	insinto /home/httpd/htdocs/phpmyadmin/libraries/auth
	doins libraries/auth/*.php

	dodoc ANNOUNCE.txt CREDITS ChangeLog TODO Documentation.{txt,html} \
		INSTALL LICENSE RELEASE-DATE*
}

pkg_postinst() {
	einfo
	einfo "Make sure you edit /home/httpd/htdocs/phpmyadmin/config.inc.php"
	einfo
}
