# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.3.3.ebuild,v 1.3 2003/01/10 20:37:43 joker Exp $

MY_PN=phpMyAdmin

S=${WORKDIR}/${MY_PN}-${PV}pl1
DESCRIPTION="Web-based administration for MySQL database in php"
SRC_URI="http://umn.dl.sourceforge.net/sourceforge/phpmyadmin/${MY_PN}-${PV}pl1-php.tar.bz2"
HOMEPAGE="http://phpmyadmin.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
# only known to work on x86... can people test on other platforms?
KEYWORDS="~x86 ~sparc"

DEPEND=">=net-www/apache-1.3.24-r1 >=dev-db/mysql-3.23.38 >=dev-php/mod_php-4.1.2-r5"

# FIX- Plz check if path of config file (/etc/apache2/conf/apache2.conf)
# is correct because i'm not using apache2 now, thanx - Quequero

src_compile() { :; }

src_install () {
	cd ${S}
	cp config.inc.php config.inc.php.orig

	# We set these two variables so myphpadmin is able to run even if no one configured config.inc.php
	# - Quequero
	sed -e "s:PmaAbsoluteUri'] = '':PmaAbsoluteUri'] = 'http\://localhost/phpmyadmin/':" \
		-e "s:auth_type']     = 'config':auth_type']     = 'http':" \
	config.inc.php.orig > config.inc.php

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
	einfo "Then point your browser to http://<www.your-host.com>/<your-install-dir>/index.php"
	einfo
}
