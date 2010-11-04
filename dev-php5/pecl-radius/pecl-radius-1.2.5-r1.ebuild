# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-radius/pecl-radius-1.2.5-r1.ebuild,v 1.1 2010/11/04 15:47:51 mabi Exp $

EAPI=3

PHP_EXT_NAME="radius"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Provides full support for RADIUS authentication (RFC 2865) and RADIUS accounting (RFC 2866)."
LICENSE="BSD BSD-2"
SLOT="0"
IUSE="examples"
