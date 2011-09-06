# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside-tools/pyside-tools-0.2.13.ebuild,v 1.1 2011/09/06 12:42:16 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="2:2.5"

inherit python cmake-utils virtualx

DESCRIPTION="PySide development tools"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

RDEPEND=">=dev-python/pyside-1.0.6
	>=x11-libs/qt-core-4.7.0
	>=x11-libs/qt-gui-4.7.0"
DEPEND="${DEPEND}
	test? ( >=x11-libs/qt-test-4.7.0 )"

DOCS=( AUTHORS ChangeLog )

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed -e 's#pyside-rcc4#PATH=$PATH:${WORKDIR}/${P}_build/pyrcc pyside-rcc#' \
		-i tests/rcc/run_test.sh \
		|| die "sed failed"

	python_convert_shebangs -r 2 pyside-uic
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}

src_test() {
	VIRTUALX_COMMAND="cmake-utils_src_test"
	virtualmake
}
