# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/phpsyslogng/phpsyslogng-2.8.ebuild,v 1.2 2006/01/21 19:52:05 strerror Exp $

inherit webapp

DESCRIPTION="php-syslog-ng is a log monitor designed to easily manage logs from many hosts."
HOMEPAGE="http://www.phpwizardry.com/php-syslog-ng.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SRC_URI="http://www.phpwizardry.com/php-syslog-ng/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="mysql"

RDEPEND="virtual/httpd-php
		mysql? ( >=dev-db/mysql-4.1 )"

src_install() {
	webapp_src_preinst

	dodoc README CHANGELOG
	rm LICENSE README CHANGELOG
	dodoc scripts/*

	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/config/config.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
