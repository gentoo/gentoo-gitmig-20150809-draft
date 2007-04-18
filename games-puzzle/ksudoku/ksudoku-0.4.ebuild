# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ksudoku/ksudoku-0.4.ebuild,v 1.1 2007/04/18 12:32:48 jokey Exp $

inherit kde

DESCRIPTION="Sudoku Puzzle Generator and Solver for KDE"
HOMEPAGE="http://ksudoku.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

need-kde 3.3

DEPEND=">=dev-util/cmake-2.4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:LINK_FLAGS "${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED} ${_BASE_LDADD}"):LINK_FLAGS "${_BASE_LDADD} ${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED}"):' \
		src/CMakeLists.txt
}

src_compile() {
	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr					\
		-DCMAKE_BUILD_TYPE=Release					\
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC))		\
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX))	\
		-DCMAKE_CXX_FLAGS="-DQT_THREAD_SUPPORT"		\
		-DLIB_INSTALL_DIR=/usr/$(get_libdir) 		\
		|| die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
