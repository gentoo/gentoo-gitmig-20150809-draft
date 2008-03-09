# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/avogadro/avogadro-0.6.1.ebuild,v 1.1 2008/03/09 03:08:17 cryos Exp $

RESTRICT="mirror"

inherit toolchain-funcs multilib

DESCRIPTION="Advanced molecular editor that uses Qt4 and OpenGL"
HOMEPAGE="http://avogadro.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/cmake-2.4.6
	>=dev-cpp/eigen-1.0.5
	${RDEPEND}"
RDEPEND=">=x11-libs/qt-4.3.0
	>=sci-chemistry/openbabel-2.2.0_beta4"

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr \
		-DLIBRARY_OUTPUT_PATH=PROJECT_BINARY_DIR/$(get_libdir) \
		-DCMAKE_BUILD_TYPE=Release \
		-DLIB_INSTALL_DIR=$(get_libdir) \
		-DCMAKE_C_COMPILER=$(type -p $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -p $(tc-getCXX)) || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
