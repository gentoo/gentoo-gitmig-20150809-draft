# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-qt/php-qt-0.0.3.ebuild,v 1.2 2006/09/29 13:40:42 sebastian Exp $

PHP_EXT_NAME="php_qt"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="PHP 5 bindings for the Qt4 framework."
HOMEPAGE="http://php-qt.berlios.de"
SRC_URI="http://download.berlios.de/php-qt/php_qt-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
	=x11-libs/qt-4*"

S="${WORKDIR}/php_qt"

need_php_by_category

pkg_setup() {
	pkg="`best_version '=x11-libs/qt-4*'`"
	if ! built_with_use =${pkg} accessibility ; then
		die "You need to re-emerge x11-libs/qt with USE=accessibility."
	fi
}
