# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/kicad/kicad-20080914.1262.ebuild,v 1.2 2008/09/22 07:17:11 calchan Exp $

inherit versionator wxwidgets cmake-utils

MY_PV="$(get_major_version)-r$(get_after_major_version)"

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://kicad.sourceforge.net"
SRC_URI="http://dev.gentoo.org/~calchan/distfiles/${PN}-${MY_PV}.tar.bz2
	!minimal? ( http://dev.gentoo.org/~calchan/distfiles/${PN}-library-${MY_PV}.tar.bz2 )
	doc? ( http://dev.gentoo.org/~calchan/distfiles/${PN}-doc-${MY_PV}.tar.bz2 )
	examples? ( http://dev.gentoo.org/~calchan/distfiles/${PN}-examples-${MY_PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc debug examples minimal python"

RDEPEND="sys-libs/zlib
	=x11-libs/wxGTK-2.8*
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	dev-libs/boost
	>=dev-util/cmake-2.6.0"

S="${WORKDIR}/${PN}"

pkg_setup() {
	WX_GTK_VER="2.8"
	need-wxwidgets unicode
	check_wxuse opengl
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use minimal ; then
		sed -i -e "s:add_subdirectory(kicad-library):#add_subdirectory(kicad-library):" \
		CMakeLists.txt || die "sed failed"
	fi

	if ! use doc ; then
		sed -i -e "s:add_subdirectory(kicad-doc):#add_subdirectory(kicad-doc):" \
		CMakeLists.txt || die "sed failed"
	fi

	if ! use examples ; then
		sed -i -e "s:^add_subdirectory(demos):#add_subdirectory(demos):" \
		CMakeLists.txt || die "sed failed"
	fi
}

src_compile() {
	cmakeargs="-DKICAD_MINIZIP=OFF"

	if use python ; then
		cmakeargs+=" -DKICAD_PYTHON=ON"
	else
		cmakeargs+=" -DKICAD_PYTHON=OFF"
	fi

	cmake-utils_src_compile
}

pkg_postinst() {
	if use minimal ; then
		ewarn "If the schematic and/or board editors complain about missing libraries when you"
		ewarn "open old projects, you will have to take one or more of the following actions :"
		ewarn "- Install the missing libraries manually."
		ewarn "- Remove the libraries from the 'Libs and Dir' preferences."
		ewarn "- Fix the libraries' locations in the 'Libs and Dir' preferences."
		ewarn "- Emerge kicad without the 'minimal' USE flag."
	fi
	elog
	elog "You may want to emerge media-gfx/wings if you want to create 3D models of components."
}
