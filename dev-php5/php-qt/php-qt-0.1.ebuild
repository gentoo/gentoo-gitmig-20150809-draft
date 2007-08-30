# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-qt/php-qt-0.1.ebuild,v 1.1 2007/08/30 13:09:06 jokey Exp $

inherit eutils kde-functions qt4 toolchain-funcs depend.php

DESCRIPTION="PHP5 bindings for the Qt4 framework."
HOMEPAGE="http://php-qt.org/"
SRC_URI="http://download.berlios.de/php-qt/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=kde-base/smoke-3.5.6
	$(qt4_min_version 4)"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4"

need_php_by_category

S="${WORKDIR}/${PN/-/_}"

pkg_setup() {
	has_php
	if built_with_use =${PHP_PKG} threads; then
		eerror "dev-lang/php must be compiled without \"threads\" support."
		die "Recompile ${PHP_PKG} with USE=\"-threads\" and try again."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	set-kdedir
	sed -i -e "/add_subdirectory(smoke)/d" CMakeLists.txt
	sed -i -e "/\/smoke/d" -e "/include_directories/a\\
		${KDEDIR}/include" php_qt/CMakeLists.txt
}

src_compile() {
	cmake \
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC)) \
		-DCMAKE_C_FLAGS="${CFLAGS}" \
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX)) \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
		-DQT_QMAKE_EXECUTABLE="/usr/bin/qmake" \
		-DCMAKE_INSTALL_PREFIX=/usr \
		|| die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc COPYING CREDITS README #COPYING is a dependent license
	insinto /usr/share/doc/${PF}/examples/
	doins -r "${S}"/examples/*
}
