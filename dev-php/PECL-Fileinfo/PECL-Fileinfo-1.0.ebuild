# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-Fileinfo/PECL-Fileinfo-1.0.ebuild,v 1.1 2005/07/01 05:23:50 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="Fileinfo"
PHP_EXT_NAME="fileinfo"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="libmagic bindings for PHP."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86"
DEPEND="${DEPEND} sys-apps/file"

src_install () {
	php-ext-pecl_src_install
}
