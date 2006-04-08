# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-fileinfo/pecl-fileinfo-1.0.3.ebuild,v 1.8 2006/04/08 10:45:08 blubb Exp $

PHP_EXT_NAME="fileinfo"
PHP_EXT_PECL_PKG="Fileinfo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="amd64 ~hppa ppc ppc64 sparc x86"
DESCRIPTION="libmagic bindings for PHP."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		sys-apps/file"

need_php_by_category
