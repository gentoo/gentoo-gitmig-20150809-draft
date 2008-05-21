# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ksudoku/ksudoku-0.4.ebuild,v 1.12 2008/05/21 18:56:54 jokey Exp $

inherit flag-o-matic multilib kde eutils

DESCRIPTION="Sudoku Puzzle Generator and Solver for KDE"
HOMEPAGE="http://ksudoku.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-util/cmake-2.4.6"

need-kde 3.3

pkg_setup() {
	if ! built_with_use "=x11-libs/qt-3*" opengl ; then
		eerror "This needs qt3 built with opengl support to work sanely"
		die "This needs qt3 built with opengl"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch #218297

	sed -i \
		-e 's:LINK_FLAGS "${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED} ${_BASE_LDADD}"):LINK_FLAGS "${_BASE_LDADD} ${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED}"):' \
		src/CMakeLists.txt \
		|| die "sed failed"
}

src_compile() {
	filter-ldflags "--as-needed" "-Wl,--as-needed"

	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX)) \
		-DCMAKE_CXX_FLAGS="-DQT_THREAD_SUPPORT" \
		-DLIB_INSTALL_DIR=/usr/$(get_libdir) \
		|| die "cmake failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
}
