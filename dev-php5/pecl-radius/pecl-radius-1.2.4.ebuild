# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-radius/pecl-radius-1.2.4.ebuild,v 1.2 2006/03/03 07:34:52 sebastian Exp $

PHP_EXT_NAME="radius"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~x86"
DESCRIPTION="Provides full support for RADIUS authentication (RFC 2865) and RADIUS accounting (RFC 2866)."
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	has_php
	my_conf="--with-radius"
	php-ext-pecl-r1_src_compile
}
