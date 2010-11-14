# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-bbcode/pecl-bbcode-1.0.3_beta1.ebuild,v 1.1 2010/11/14 18:57:16 olemarkus Exp $

EAPI="2"

PHP_EXT_NAME="bbcode"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

USE_PHP="php5-2 php5-3"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

MY_PV="${PV/_beta/b}"
PECL_PKG_V="${PECL_PKG}-${MY_PV}"
FILENAME="${PECL_PKG_V}.tgz"
SRC_URI="http://pecl.php.net/get/${FILENAME}"
HOMEPAGE="http://pecl.php.net/${PECL_PKG}"

DESCRIPTION="A quick and efficient BBCode Parsing Library."
LICENSE="PHP-3.01 BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PECL_PKG_V}"
