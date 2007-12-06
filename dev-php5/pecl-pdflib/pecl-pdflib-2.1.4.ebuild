# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdflib/pecl-pdflib-2.1.4.ebuild,v 1.2 2007/12/06 01:19:58 jokey Exp $

PHP_EXT_NAME="pdf"
PHP_EXT_PECL_PKG="pdflib"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP extension for creating PDF files."
LICENSE="PHP-2.02 PHP-3"
SLOT="0"
IUSE=""

DEPEND="media-libs/pdflib"
RDEPEND="${DEPEND}"

need_php_by_category
