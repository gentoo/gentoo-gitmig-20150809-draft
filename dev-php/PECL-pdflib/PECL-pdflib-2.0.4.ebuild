# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-pdflib/PECL-pdflib-2.0.4.ebuild,v 1.3 2005/07/12 17:25:57 weeve Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="pdflib"
PHP_EXT_NAME="pdf"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="PHP extension for creating PDF files."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~sparc x86"
DEPEND="${DEPEND}
	media-libs/pdflib"
