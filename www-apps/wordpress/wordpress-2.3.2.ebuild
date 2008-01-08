# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wordpress/wordpress-2.3.2.ebuild,v 1.1 2008/01/08 06:29:52 wrobel Exp $

inherit webapp eutils depend.php

DESCRIPTION="Wordpress php and mysql based CMS system."
HOMEPAGE="http://wordpress.org/"
SRC_URI="http://www.wordpress.org/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/httpd-cgi"

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

	cp wp-config-sample.php wp-config.php
	cp -r * "${D}${MY_HTDOCSDIR}"

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f "${D}${MY_HTDOCSDIR}/${doc}"
	done

	# Identify files/directory that should be writeable to
	# the web server
	webapp_serverowned "${MY_HTDOCSDIR}"/index.php
	webapp_serverowned "${MY_HTDOCSDIR}"/wp-admin/menu.php
	webapp_serverowned "${MY_HTDOCSDIR}"

	# Identify the configuration files that this app uses
	# User may want to make changes to these!
	webapp_configfile  "${MY_HTDOCSDIR}"/wp-config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt

	webapp_src_install
}
