# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-6.11.ebuild,v 1.1 2009/05/01 17:54:02 pva Exp $

inherit webapp eutils depend.php

MY_PV=${PV:0:3}.0

DESCRIPTION="PHP-based open-source platform and content management system"
HOMEPAGE="http://drupal.org/"
SRC_URI="http://drupal.org/files/projects/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	has_php
	if [[ ${PHP_VERSION} == "4" ]] ; then
		local flags="expat"
	else
		local flags="xml"
	fi
	if ! PHPCHECKNODIE="yes" require_php_with_use ${flags} \
		|| ! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external ; then
			die "Re-install ${PHP_PKG} with ${flags} and either gd or gd-external"
	fi
}

src_install() {
	webapp_src_preinst

	local docs="MAINTAINERS.txt LICENSE.txt INSTALL.txt CHANGELOG.txt INSTALL.mysql.txt INSTALL.pgsql.txt UPGRADE.txt "
	dodoc ${docs}
	rm -f ${docs} INSTALL COPYRIGHT.txt

	cp sites/default/{default.settings.php,settings.php}
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	dodir "${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/sites/default
	webapp_serverowned "${MY_HTDOCSDIR}"/sites/default/settings.php

	webapp_configfile "${MY_HTDOCSDIR}"/sites/default/settings.php
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
