# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-fileinfo/pecl-fileinfo-1.0.4.ebuild,v 1.6 2007/06/01 17:10:40 nixnut Exp $

PHP_EXT_NAME="fileinfo"
PHP_EXT_PECL_PKG="Fileinfo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="amd64 hppa ppc ppc64 sparc x86"

DESCRIPTION="libmagic bindings for PHP."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="sys-apps/file"
RDEPEND="${DEPEND}"

need_php_by_category
