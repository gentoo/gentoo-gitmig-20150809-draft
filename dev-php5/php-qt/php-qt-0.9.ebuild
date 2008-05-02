# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-qt/php-qt-0.9.ebuild,v 1.3 2008/05/02 16:22:07 chtekk Exp $

PHP_EXT_NAME="php_qt"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHPSAPILIST="cli"
inherit php-ext-base-r1 qt4 eutils depend.php cmake-utils

DESCRIPTION="PHP5 bindings for the Qt4 framework."
HOMEPAGE="http://php-qt.org/"
SRC_URI="mirror://berlios/php-qt/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="$(qt4_min_version 4)
	>=x11-libs/qscintilla-2.1-r1
	!kde-base/smoke" # yes, this IS required, installs a bundled QT4-compatible copy

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4
	dev-lang/perl"

need_php_by_category

S="${WORKDIR}/${PN/-}"

pkg_setup() {
	require_php_cli
	if built_with_use =${PHP_PKG} threads; then
		eerror "dev-lang/php must be compiled without threads support."
		die "Recompile ${PHP_PKG} with USE=\"-threads\" and try again."
	fi
	if ! built_with_use x11-libs/qscintilla qt4 ; then
		eerror  "x11-libs/qscintilla must be compiled with qt4 support."
		die "Recompile x11-libs/qscintilla with USE=\"qt4\" and try again."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Bug 208301
	epatch "${FILESDIR}"/${P}-no-qwt.patch
}

src_compile() {
	local mycmakeargs="-DQT_QMAKE_EXECUTABLE=/usr/bin/qmake -DQSCINTILLA_INCLUDE_DIR=/usr/include/Qsci"
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	php-ext-base-r1_src_install

	# COPYING is a dependent license
	dodoc-php COPYING ChangeLog CREDITS README
	insinto /usr/share/doc/${CATEGORY}/${PF}/examples/
	doins -r "${S}"/examples/*
	insinto /usr/share/doc/${CATEGORY}/${PF}/tutorials/
	doins -r "${S}"/tutorials/*
}
