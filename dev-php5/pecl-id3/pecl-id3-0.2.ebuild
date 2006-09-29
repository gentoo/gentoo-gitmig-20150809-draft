# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-id3/pecl-id3-0.2.ebuild,v 1.1 2006/09/29 20:28:12 sebastian Exp $

PHP_EXT_NAME="id3"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Read and write ID3 tags in MP3 files with PHP."
LICENSE="PHP"
SLOT="0"
IUSE=""

need_php_by_category
