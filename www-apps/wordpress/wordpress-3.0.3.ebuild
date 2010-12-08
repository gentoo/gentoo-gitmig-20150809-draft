# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wordpress/wordpress-3.0.3.ebuild,v 1.1 2010/12/08 23:28:58 radhermit Exp $

EAPI="2"

inherit webapp depend.php

DESCRIPTION="Wordpress php and mysql based CMS system."
HOMEPAGE="http://wordpress.org/"
SRC_URI="http://wordpress.org/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( dev-lang/php[mysql] dev-lang/php[mysqli] )
		 || ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"

S="${WORKDIR}"/${PN}

need_httpd_cgi
need_php_httpd

src_install() {
	webapp_src_preinst

	dohtml readme.html
	rm -f readme.html license.txt

	[ -f wp-config.php ] || cp wp-config-sample.php wp-config.php

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/index.php
	webapp_serverowned "${MY_HTDOCSDIR}"/wp-admin/menu.php
	webapp_serverowned "${MY_HTDOCSDIR}"

	webapp_configfile  "${MY_HTDOCSDIR}"/wp-config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt

	webapp_src_install
}
