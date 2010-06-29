# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside-tools/pyside-tools-0.1.3.ebuild,v 1.2 2010/06/29 17:58:04 ayoy Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="PySide development tools"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

DEPEND=">=dev-python/pyside-0.3.2
	>=x11-libs/qt-core-4.6.0
	>=x11-libs/qt-gui-4.6.0"
RDEPEND="${DEPEND}"

src_test() {
	cd "${S}"/tests/rcc
	./run_test.sh $(which python) ./rcc_test.py ./example.qrc . \
		|| die "tests failed"
}

src_install() {
	cmake-utils_src_install
	dobin pyside-uic || die "installing pyside-uic failed"
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
