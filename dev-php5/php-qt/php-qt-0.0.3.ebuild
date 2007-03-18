# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-qt/php-qt-0.0.3.ebuild,v 1.3 2007/03/18 02:09:47 chtekk Exp $

PHP_EXT_NAME="php_qt"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP5 bindings for the Qt4 framework."
HOMEPAGE="http://www.php-qt.org/"
SRC_URI="http://download.berlios.de/php-qt/php_qt-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="=x11-libs/qt-4*"
RDEPEND="${DEPEND}"

S="${WORKDIR}/php_qt"

need_php_by_category

pkg_setup() {
	pkg="`best_version '=x11-libs/qt-4*'`"
	if ! built_with_use =${pkg} accessibility ; then
		eerror "You need to emerge x11-libs/qt-4 with the 'accessibility' USE flag enabled."
		die "Emerge x11-libs/qt-4 with the 'accessibility' USE flag enabled."
	fi
}
