# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.3.2-r1.ebuild,v 1.5 2003/02/15 07:25:17 gerk Exp $

MY_PN=phpMyAdmin

S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Web-based administration for MySQL database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-php.tar.bz2"
HOMEPAGE="http://phpmyadmin.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"

# only known to work on x86... can people test on other platforms?
KEYWORDS="x86 sparc ppc"

DEPEND=">=net-www/apache-1.3.24-r1 >=dev-db/mysql-3.23.38 >=dev-php/mod_php-4.1.2-r5"

src_compile() { :; }

src_install () {
	insinto /home/httpd/htdocs/phpmyadmin
	doins *.{php,html}

	insinto /home/httpd/htdocs/phpmyadmin/images
	doins images/*.{gif,png}

	insinto /home/httpd/htdocs/phpmyadmin/scripts
	doins scripts/*.{php,sh}

	insinto /home/httpd/htdocs/phpmyadmin/lang
	doins lang/*.{php,sh}

	insinto /home/httpd/htdocs/phpmyadmin/libraries
	doins libraries/*.{php,js}

	insinto /home/httpd/htdocs/phpmyadmin/libraries/auth
	doins libraries/auth/*.php

	insinto /home/httpd/htdocs/phpmyadmin/libraries/fpdf
	doins libraries/fpdf/*.php

	insinto /home/httpd/htdocs/phpmyadmin/libraries/fpdf/font
	doins libraries/fpdf/font/*.php

	insinto /home/httpd/htdocs/phpmyadmin/libraries/xpath
	doins libraries/xpath/*.php

	dodoc ANNOUNCE.txt CREDITS ChangeLog TODO Documentation.{txt,html} \
		INSTALL LICENSE RELEASE-DATE*
}

pkg_postinst() {
	einfo
	einfo "Make sure you edit /home/httpd/htdocs/phpmyadmin/config.inc.php"
	einfo
}
