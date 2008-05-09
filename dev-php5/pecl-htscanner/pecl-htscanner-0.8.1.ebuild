# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-htscanner/pecl-htscanner-0.8.1.ebuild,v 1.7 2008/05/09 12:58:12 hoffie Exp $

PHP_EXT_NAME="htscanner"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"
PHPSAPILIST="cgi"

inherit php-ext-pecl-r1 eutils depend.php php-ext-base-r1

KEYWORDS="amd64 x86"

DESCRIPTION="Enables .htaccess options for php-scripts running as cgi."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

need_php_by_category
my_conf="--enable-htscanner"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-bug11959.patch
	php-ext-source-r1_phpize
}

pkg_setup() {
	has_php
	require_php_sapi_from cgi
}

src_install() {
	php-ext-pecl-r1_src_install

	php-ext-base-r1_addtoinifiles "config_file" ".htaccess"
	php-ext-base-r1_addtoinifiles "default_docroot" "/"
	php-ext-base-r1_addtoinifiles "default_ttl" "300"
	php-ext-base-r1_addtoinifiles "stop_on_error" "0"
}
