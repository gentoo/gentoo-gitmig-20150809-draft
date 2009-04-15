# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/phpsyslogng/phpsyslogng-2.8-r1.ebuild,v 1.4 2009/04/15 07:46:17 hoffie Exp $

inherit webapp

DESCRIPTION="php-syslog-ng is a log monitor designed to easily manage logs from many hosts."
HOMEPAGE="http://www.phpwizardry.com/php-syslog-ng.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SRC_URI="http://www.phpwizardry.com/php-syslog-ng/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc64 ~x86"
IUSE="mysql"

RDEPEND="virtual/httpd-php
		mysql? ( >=virtual/mysql-4.1 )"

src_install() {
	webapp_src_preinst

	dodoc README CHANGELOG
	rm LICENSE README CHANGELOG
	dodoc scripts/*

	cp -r . "${D}${MY_HTDOCSDIR}"
	cp	"${FILESDIR}"/logrotate.php "${D}${MY_HTDOCSDIR}"/scripts

	webapp_configfile "${MY_HTDOCSDIR}"/config/config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
