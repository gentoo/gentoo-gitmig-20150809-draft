# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wordpress/wordpress-2.3.ebuild,v 1.1 2007/10/08 12:55:42 anant Exp $

inherit webapp eutils depend.php

DESCRIPTION="Wordpress php and mysql based CMS system."
HOMEPAGE="http://wordpress.org/"
SRC_URI="http://www.wordpress.org/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

need_php

pkg_setup() {
	webapp_pkg_setup

	require_php_with_any_use mysql mysqli
	require_php_with_use pcre
}

src_install() {
	local docs="license.txt readme.html"

	webapp_src_preinst

	einfo "Installing main files"
	cp wp-config-sample.php wp-config.php
	cp -r * "${D}${MY_HTDOCSDIR}"
	einfo "Done"

	ewarn "                                                            "
	ewarn "Please make sure you have register_globals = off set in your"
	ewarn "/etc/apache2/php.ini file                                   "
	ewarn "If this is not an option for your web server and you NEED it"
	ewarn "set to on, then insert the following in your WordPress      "
	ewarn ".htaccess file:                                             "
	ewarn "php_flag register_globals off                               "
	ewarn "                                                            "

	ewarn "                                                            "
	ewarn "You will need to create a table for your WordPress database."
	ewarn "This assumes you have some knowledge of MySQL, and already  "
	ewarn "have it installed and configured.  If not, please refer to  "
	ewarn "the Gentoo MySQL guide at the following URL:                "
	ewarn "http://www.gentoo.org/doc/en/mysql-howto.xml                "
	ewarn "Log in to MySQL, and create a new database called           "
	ewarn "'wordpress'. From this point, you will need to edit your    "
	ewarn "wp-config.php file in $DocumentRoot/wordpress/ and point to "
	ewarn "your database. Once this is done, you can log in to         "
	ewarn "WordPress at http://localhost/wordpress                     "
	ewarn "                                                            "

	ewarn "                                                            "
	ewarn "If you are upgrading from a previous version BACK UP your   "
	ewarn "database.  Once you are done with that, browse to           "
	ewarn "http://localhost/wordpress/wp-admin/upgrade.php and follow  "
	ewarn "the instructions on the screen.                             "
	ewarn "                                                            "

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	dodoc "${docs}"
	for doc in "${docs}" INSTALL; do
		rm -f "${doc}"
	done

	# Identify the configuration files that this app uses
	# User can want to make changes to these!
	webapp_serverowned "${MY_HTDOCSDIR}/index.php"
	webapp_serverowned "${MY_HTDOCSDIR}/wp-admin/menu.php"
	webapp_serverowned "${MY_HTDOCSDIR}"
	webapp_configfile  "${MY_HTDOCSDIR}/wp-config.php"

	# now strut stuff
	webapp_src_install
}
