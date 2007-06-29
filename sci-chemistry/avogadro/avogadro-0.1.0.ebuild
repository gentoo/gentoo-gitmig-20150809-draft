# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/avogadro/avogadro-0.1.0.ebuild,v 1.2 2007/06/29 07:00:27 opfer Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Advanced molecular editor that uses Qt4 and OpenGL"
HOMEPAGE="http://avogadro.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/cmake-2.4.3
	>=dev-cpp/eigen-1.0.5
	${RDEPEND}"
RDEPEND=">=x11-libs/qt-4.2.3
	>=sci-chemistry/openbabel-2.1.0"

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr \
		-DLIBRARY_OUTPUT_PATH=PROJECT_BINARY_DIR/$(get_libdir) \
		-DLIB_INSTALL_DIR=$(get_libdir) \
		-DCMAKE_C_COMPILER=$(type -p $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -p $(tc-getCXX)) || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
