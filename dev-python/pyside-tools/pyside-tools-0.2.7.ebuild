# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside-tools/pyside-tools-0.2.7.ebuild,v 1.1 2011/03/20 20:09:52 chiiph Exp $

EAPI="2"

PYTHON_DEPEND="2:2.5"

inherit cmake-utils python

DESCRIPTION="PySide development tools"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

DEPEND=">=dev-python/pyside-0.4.0
	>=x11-libs/qt-core-4.6.0
	>=x11-libs/qt-gui-4.6.0"
RDEPEND="${DEPEND}"

TEST_VERBOSE=1

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed -e 's#pyside-rcc4#PATH=$PATH:${WORKDIR}/${P}_build/pyrcc pyside-rcc#' \
		-i tests/rcc/run_test.sh \
		|| die "sed failed"

	python_convert_shebangs -r 2 pyside-uic
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
