# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-fileinfo/pecl-fileinfo-1.0.4-r2.ebuild,v 1.1 2011/12/14 22:35:12 mabi Exp $

EAPI="3"

PHP_EXT_NAME="fileinfo"
PHP_EXT_PECL_PKG="Fileinfo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

# fileinfo is bundled with php5.3
USE_PHP="php5-2"

inherit php-ext-pecl-r2

KEYWORDS="amd64 hppa x86"

DESCRIPTION="libmagic bindings for PHP."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="sys-apps/file"
RDEPEND="${DEPEND}"

src_prepare() {
	for slot in $(php_get_slots) ; do
		cd "${WORKDIR}/${slot}"
		epatch "${FILESDIR}"/fileinfo-1.0.4-file-5.0-compat.patch
	done
	php-ext-source-r2_src_prepare
}
