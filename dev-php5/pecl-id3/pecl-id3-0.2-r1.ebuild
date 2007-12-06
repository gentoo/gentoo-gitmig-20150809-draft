# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-id3/pecl-id3-0.2-r1.ebuild,v 1.1 2007/12/06 01:10:42 jokey Exp $

PHP_EXT_NAME="id3"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="EXPERIMENTAL TODO"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Read and write ID3 tags in MP3 files with PHP."
LICENSE="PHP-3"
SLOT="0"
IUSE="examples"

DEPEND=""
RDEPEND=""

need_php_by_category
