# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-yaz/pecl-yaz-1.0.8.ebuild,v 1.10 2007/06/24 21:30:38 vapier Exp $

PHP_EXT_NAME="yaz"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"

DESCRIPTION="This extension implements a Z39.50 client for PHP using the YAZ toolkit."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/yaz-2.0.13"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	my_conf="--with-yaz=/usr"
	php-ext-pecl-r1_src_compile
}
