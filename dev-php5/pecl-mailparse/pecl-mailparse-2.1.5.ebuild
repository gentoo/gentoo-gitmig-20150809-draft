# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-mailparse/pecl-mailparse-2.1.5.ebuild,v 1.3 2010/09/30 10:22:14 hwoarang Exp $

EAPI="2"

PHP_EXT_NAME="mailparse"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

DOCS="README"

inherit php-ext-pecl-r1

KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
LICENSE="PHP-2.02"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[unicode]"
RDEPEND=""

need_php_by_category
