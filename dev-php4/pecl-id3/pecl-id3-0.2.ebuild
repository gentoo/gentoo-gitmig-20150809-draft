# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-id3/pecl-id3-0.2.ebuild,v 1.2 2007/03/06 19:57:05 chtekk Exp $

PHP_EXT_NAME="id3"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Read and write ID3 tags in MP3 files with PHP."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category
