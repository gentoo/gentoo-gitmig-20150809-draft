# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PHPonTrax/PHPonTrax-0.14.0.ebuild,v 1.1 2011/09/18 10:51:30 olemarkus Exp $

inherit php-pear-r1 depend.php depend.apache

DESCRIPTION="Web-application and persistance framework based on Ruby on Rails"
HOMEPAGE="http://www.phpontrax.org/"
SRC_URI="http://pear.phpontrax.com/get/${P}.tgz"

LICENSE="MIT"
SLOT="0"
IUSE="mysql postgres sqlite"

KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-php/PEAR-PEAR-1.6.2"
RDEPEND="dev-php/PEAR-MDB2
	dev-php/PEAR-Mail
	dev-php/PEAR-Mail_Mime
	mysql? ( dev-php/PEAR-MDB2_Driver_mysql )
	postgres? ( dev-php/PEAR-MDB2_Driver_pgsql )
	sqlite? ( dev-php/PEAR-MDB2_Driver_sqlite )
	!mysql? ( !postgres? ( !sqlite? ( dev-php/PEAR-MDB2_Driver_mysql ) ) )"

need_php5_httpd
need_apache2

pkg_setup() {
	# We are not checking for php database features since
	# the PEAR-MDB2_* ebuilds in RDEPEND already take care of this.
	require_php_sapi_from apache2 cgi
	require_php_with_use session imap
}

pkg_postinst() {
	ewarn "This packages requires that you enable mod_rewrite in apache-2."
}
