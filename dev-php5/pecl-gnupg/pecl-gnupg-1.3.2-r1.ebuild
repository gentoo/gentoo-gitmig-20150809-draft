# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-gnupg/pecl-gnupg-1.3.2-r1.ebuild,v 1.1 2010/11/04 13:13:32 mabi Exp $

PHP_EXT_NAME="gnupg"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

EAPI="3"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"
DESCRIPTION="PHP wrapper around the gpgme library"
LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="app-crypt/gpgme"
RDEPEND="${DEPEND}"
