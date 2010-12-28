# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdflib/pecl-pdflib-2.1.8-r1.ebuild,v 1.2 2010/12/28 19:26:59 ranger Exp $

EAPI=3

PHP_EXT_NAME="pdf"
PHP_EXT_PECL_PKG="pdflib"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~ppc64 ~x86"

DESCRIPTION="PHP extension for creating PDF files."
LICENSE="PHP-2.02 PHP-3"
SLOT="0"
IUSE=""

DEPEND="media-libs/pdflib"
RDEPEND="${DEPEND}"
