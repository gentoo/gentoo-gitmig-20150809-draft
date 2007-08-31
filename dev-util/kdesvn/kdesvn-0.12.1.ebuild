# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-0.12.1.ebuild,v 1.2 2007/08/31 12:47:12 george Exp $

inherit eutils versionator kde-functions toolchain-funcs

My_PV=$(get_version_component_range 1-2)

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
SRC_URI="http://www.alwins-world.de/programs/download/${PN}/${My_PV}.x/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=dev-util/subversion-1.3
		net-misc/neon
		>=dev-util/cmake-2.4"

need-kde 3.3

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:LINK_FLAGS "${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED} ${_BASE_LDADD}"):LINK_FLAGS "${_BASE_LDADD} ${APR_EXTRA_LIBFLAGS} ${APU_EXTRA_LIBFLAGS} ${LINK_NO_UNDEFINED}"):' \
		src/CMakeLists.txt
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
		-DCMAKE_CXX_FLAGS="-DQT_THREAD_SUPPORT"		\
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
