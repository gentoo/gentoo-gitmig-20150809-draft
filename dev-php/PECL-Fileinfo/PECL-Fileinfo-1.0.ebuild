# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-Fileinfo/PECL-Fileinfo-1.0.ebuild,v 1.2 2005/08/07 09:26:34 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="Fileinfo"
PHP_EXT_NAME="fileinfo"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="libmagic bindings for PHP."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~amd64 x86"
DEPEND="${DEPEND} sys-apps/file"

src_install () {
	php-ext-pecl_src_install
}
