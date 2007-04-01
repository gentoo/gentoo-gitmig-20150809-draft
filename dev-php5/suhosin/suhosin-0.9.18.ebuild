# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/suhosin/suhosin-0.9.18.ebuild,v 1.2 2007/04/01 07:55:46 vapier Exp $

PHP_EXT_NAME="suhosin"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~alpha ~amd64 arm ~hppa ia64 ~ppc ~ppc64 s390 sh ~sparc ~x86 ~x86-fbsd"

DESCRIPTION="Suhosin is an advanced protection system for PHP installations."
HOMEPAGE="http://www.suhosin.org/"
SRC_URI="http://www.hardened-php.net/suhosin/_media/${P}.tgz"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use unicode
}

src_install() {
	php-ext-source-r1_src_install
	dodoc-php CREDITS

	for inifile in ${PHPINIFILELIST} ; do
		insinto "${inifile/${PHP_EXT_NAME}.ini/}"
		insopts -m644
		doins "suhosin.ini"
	done
}
