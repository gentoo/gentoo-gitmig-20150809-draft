# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/adodb-ext/adodb-ext-503.ebuild,v 1.2 2005/11/24 21:11:26 chtekk Exp $

PHP_EXT_INI="yes"
PHP_EXT_NAME="adodb"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

DESCRIPTION="PHP extension providing up to 100% speedup by replacing parts of ADOdb with C code."
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="http://phplens.com/lens/dl/${P}.zip"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="${DEPEND}
		app-arch/unzip
		>=dev-php/adodb-4.65-r1"

RDEPEND="${RDEPEND}
		>=dev-php/adodb-4.65-r1"

S="${WORKDIR}/adodb-${PV}"

need_php_by_category

src_install() {
	php-ext-source-r1_src_install

	insinto "${PHP_EXT_SHARED_DIR}"
	doins test-adodb.php
	dodoc-php CREDITS README.txt
}
