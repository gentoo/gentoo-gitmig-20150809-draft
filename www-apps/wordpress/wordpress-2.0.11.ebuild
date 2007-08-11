# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wordpress/wordpress-2.0.11.ebuild,v 1.1 2007/08/11 22:17:01 beandog Exp $

inherit webapp eutils depend.php

DESCRIPTION="Wordpress php and mysql based CMS system."
HOMEPAGE="http://wordpress.org/"
SRC_URI="http://www.wordpress.org/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
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
	cp -r * ${D}${MY_HTDOCSDIR}
	einfo "Done"

	ewarn
	ewarn Please make sure you have register_globals = off set in your /etc/apache2/php.ini file
	ewarn If this is not an option for your web server and you NEED it set to on, then insert the following in your WordPress .htaccess file:
	ewarn php_flag register_globals off
	ewarn

	ewarn
	ewarn You will need to create a table for your WordPress database.  This
	ewarn assumes you have some knowledge of MySQL, and already have it
	ewarn installed and configured.  If not, please refer to
	ewarn the Gentoo MySQL guide at the following URL:
	ewarn http://www.gentoo.org/doc/en/mysql-howto.xml
	ewarn Log in to MySQL, and create a new database called
	ewarn "wordpress". From this point, you will need to edit
	ewarn your wp-config.php file in $DocumentRoot/wordpress/
	ewarn and point to your database. Once this is done, you can log in to
	ewarn WordPress at http://localhost/wordpress
	ewarn

	ewarn
	ewarn If you are upgrading from a previous version BACK UP your
	ewarn database.  Once you are done with that, browse to
	ewarn http://localhost/wordpress/wp-admin/upgrade.php and follow
	ewarn the instructions on the screen.
	ewarn

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f ${doc}
	done

	# Identify the configuration files that this app uses
	# User can want to make changes to these!
	webapp_serverowned ${MY_HTDOCSDIR}/index.php
	#webapp_serverowned ${MY_HTDOCSDIR}/wp-layout.css
	webapp_serverowned ${MY_HTDOCSDIR}/wp-admin/menu.php
	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_configfile  ${MY_HTDOCSDIR}/wp-config.php
	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	#
	# for wordpress, we *assume* that all .php files need to have CGI/BIN
	# support added

	# post-install instructions
	#webapp_postinst_txt en ${FILESDIR}/1.2/postinstall-en.txt

	# now strut stuff
	webapp_src_install
}
