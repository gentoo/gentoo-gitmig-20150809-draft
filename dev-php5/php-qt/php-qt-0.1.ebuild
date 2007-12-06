# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-qt/php-qt-0.1.ebuild,v 1.2 2007/12/06 01:23:49 jokey Exp $

PHP_EXT_NAME="php_qt"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
PHPSAPILIST="cli"
inherit php-ext-base-r1 qt4 eutils depend.php toolchain-funcs

DESCRIPTION="PHP5 bindings for the Qt4 framework."
HOMEPAGE="http://php-qt.org/"
SRC_URI="http://download.berlios.de/php-qt/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(qt4_min_version 4)
	>=x11-libs/qscintilla-2.1-r1
	!kde-base/smoke" # yes, this IS required, installs a bundled QT4-compatible copy

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4
	dev-lang/perl"

need_php_by_category

S="${WORKDIR}/${PN/-/_}"

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

src_compile() {
	cmake \
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC)) \
		-DCMAKE_C_FLAGS="${CFLAGS}" \
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX)) \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
		-DQT_QMAKE_EXECUTABLE="/usr/bin/qmake" \
		-DQSCINTILLA_INCLUDE_DIR="/usr/include/Qsci" \
		-DCMAKE_INSTALL_PREFIX=/usr \
		|| die "cmake failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	php-ext-base-r1_src_install

	# COPYING is a dependent license
	dodoc COPYING ChangeLog CREDITS README
	insinto /usr/share/doc/${PF}/examples/
	doins -r "${S}"/examples/*
}
