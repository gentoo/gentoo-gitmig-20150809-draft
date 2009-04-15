# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/phpsyslogng/phpsyslogng-2.9.8m.ebuild,v 1.1 2009/04/15 07:46:17 hoffie Exp $

inherit webapp

DESCRIPTION="php-syslog-ng is a log monitor designed to easily manage logs from many hosts."
HOMEPAGE="http://php-syslog-ng.googlecode.com/"
SRC_URI="http://php-syslog-ng.googlecode.com/files/php-syslog-ng-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="mysql"

RDEPEND="virtual/httpd-php
		mysql? ( >=virtual/mysql-4.1 )"

src_install() {
	webapp_src_preinst

	dodoc php-syslog-ng/html/README php-syslog-ng/html/CHANGELOG \
		php-syslog-ng/html/INSTALL-STEPS \
		php-syslog-ng/html/TROUBLESHOOTING-INSTALL
	rm php-syslog-ng/html/LICENSE php-syslog-ng/html/README \
		php-syslog-ng/html/CHANGELOG php-syslog-ng/html/INSTALL-STEPS \
		php-syslog-ng/html/TROUBLESHOOTING-INSTALL
	dodoc php-syslog-ng/scripts/*

	insinto "${MY_HTDOCSDIR}"
	doins -r ./php-syslog-ng/html/{.htaccess,*}

	webapp_configfile "${MY_HTDOCSDIR}/config/config.php"

	webapp_serverowned -R "${MY_HTDOCSDIR}/config/"
	webapp_serverowned -R "${MY_HTDOCSDIR}/jpcache/"

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"

	webapp_src_install
}
