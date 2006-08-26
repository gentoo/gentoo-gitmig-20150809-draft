# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-http/pecl-http-1.2.1.ebuild,v 1.1 2006/08/26 09:04:26 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="pecl_http"
PHP_EXT_NAME="http"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="Extended HTTP Support for PHP."
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

DEPEND="${DEPEND} net-misc/curl"

need_php_by_category
