# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdflib/pecl-pdflib-2.1.0.ebuild,v 1.1 2006/10/05 12:54:04 sebastian Exp $

PHP_EXT_NAME="pdf"
PHP_EXT_PECL_PKG="pdflib"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="PHP extension for creating PDF files."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		media-libs/pdflib"

need_php_by_category
