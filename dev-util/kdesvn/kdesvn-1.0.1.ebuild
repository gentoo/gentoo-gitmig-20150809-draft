# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-1.0.1.ebuild,v 1.1 2008/09/11 19:51:02 george Exp $

inherit qt3 base eutils versionator toolchain-funcs kde-functions

My_PV=$(get_version_component_range 1-2)

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
SRC_URI="http://kdesvn.alwins-world.de/trac.fcgi/downloads/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-util/subversion-1.4
	dev-db/sqlite"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4"

need-kde 3.3

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-linkage.patch || die "LIB_SUFFIX patch failed"

	# this seems to be again necessary
	sed -i -e "s:\${APR_CPP_FLAGS}:\${APR_CPP_FLAGS} \"-DQT_THREAD_SUPPORT\":" \
		CMakeLists.txt || die "QT_THREAD_SUPPORT sed failed"
}

src_compile() {
	local myconf
	if use debug ; then
		myconf="-DCMAKE_BUILD_TYPE=Debug"
	fi

	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr					\
		-DCMAKE_BUILD_TYPE=Release					\
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC))		\
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX))	\
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -DQT_THREAD_SUPPORT"		\
		-DLIB_INSTALL_DIR=/usr/$(get_libdir) 		\
		${myconf} || die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		echo
		elog "For nice graphical diffs, install kde-base/kompare."
		echo
	fi
}
