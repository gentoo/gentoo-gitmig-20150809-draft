# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksudoku/ksudoku-0.4.ebuild,v 1.1 2009/02/06 10:47:17 jokey Exp $

EAPI=2

inherit flag-o-matic multilib kde eutils

DESCRIPTION="Sudoku Puzzle Generator and Solver for KDE"
HOMEPAGE="http://ksudoku.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="x11-libs/qt:3[opengl]
	kde-base/kdelibs:3.5"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch #218297

	sed -i \
		-e 's:LINK_FLAGS "${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED} ${_BASE_LDADD}"):LINK_FLAGS "${_BASE_LDADD} ${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED}"):' \
		src/CMakeLists.txt \
		|| die "sed failed"
}

src_configure() {
	filter-ldflags "--as-needed" "-Wl,--as-needed"

	KDEDIR=/usr/kde/3.5
	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX)) \
		-DCMAKE_CXX_FLAGS="-DQT_THREAD_SUPPORT" \
		-DLIB_INSTALL_DIR=/usr/$(get_libdir) \
		|| die "cmake failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
}
