# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rutorrent/rutorrent-3.2.ebuild,v 1.1 2010/12/08 17:33:25 alexxy Exp $

inherit webapp eutils depend.php

DESCRIPTION="ruTorrent is a front-end for the popular Bittorrent client rTorrent"
HOMEPAGE="http://code.google.com/p/rutorrent/"
SRC_URI="
			http://rutorrent.googlecode.com/files/${P}.tar.gz
			http://rutorrent.googlecode.com/files/plugins-${PV}.tar.gz"

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

	insinto "${MY_HTDOCSDIR}"
	mv plugins rutorrent
	cd rutorrent
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/share
	webapp_serverowned "${MY_HTDOCSDIR}"/share/settings
	webapp_serverowned "${MY_HTDOCSDIR}"/share/torrents
	webapp_serverowned "${MY_HTDOCSDIR}"/share/users

	webapp_configfile "${MY_HTDOCSDIR}"/conf/.htaccess
	webapp_configfile "${MY_HTDOCSDIR}"/conf/config.php
	webapp_configfile "${MY_HTDOCSDIR}"/conf/access.ini
	webapp_configfile "${MY_HTDOCSDIR}"/conf/plugins.ini
	webapp_configfile "${MY_HTDOCSDIR}"/share/.htaccess

	webapp_src_install
}
