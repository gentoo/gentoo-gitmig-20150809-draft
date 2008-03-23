# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/kicad/kicad-20080320.918.ebuild,v 1.1 2008/03/23 17:40:34 calchan Exp $

inherit versionator wxwidgets cmake-utils flag-o-matic

MY_PV="$(get_major_version)-r$(get_after_major_version)"
LIB_VERSION="1.0"
DOC_VERSION="1.0"

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://kicad.sourceforge.net"
SRC_URI="mirror://sourceforge/kicad/${PN}-${MY_PV}.tar.bz2
	!minimal? ( mirror://sourceforge/kicad/${PN}-library-${LIB_VERSION}.tbz2 )
	doc? ( mirror://sourceforge/kicad/${PN}-doc-${DOC_VERSION}.tbz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc debug examples minimal"

DEPEND="=x11-libs/wxGTK-2.8*
	dev-libs/boost"

S="${WORKDIR}/${PN}"
DOCS="change_log.txt todo.txt"

pkg_setup() {
	WX_GTK_VER="2.8"
	need-wxwidgets unicode
	check_wxuse opengl
}

src_unpack() {
	unpack ${A}
	if ! use examples ; then
		sed -i -e "s:^add_subdirectory(demos):#add_subdirectory(demos):" "${S}"/CMakeLists.txt || die "sed failed"
	fi
	sed -i -e "s:^install(FILES \${CMAKE_CURRENT_SOURCE_DIR}/install\.txt:#install(FILES \${CMAKE_CURRENT_SOURCE_DIR}/install\.txt:" \
		"${S}"/CMakeLists.txt || die "sed failed"
}

src_install() {
	cmake-utils_src_install
	[[ -d "${WORKDIR}/usr" ]] && doins -r "${WORKDIR}/usr"
}

pkg_postinst() {
	if use minimal ; then
		ewarn "If the schematic and/or board editors complain about missing libraries when you open old projects,"
		ewarn "you will have to take one or more of the following actions :"
		ewarn "- Install the missing libraries manually."
		ewarn "- Remove the libraries from the 'Libs and Dir' preferences."
		ewarn "- Fix the libraries' locations in the 'Libs and Dir' preferences."
		ewarn "- Emerge kicad without the 'minimal' USE flag."
	else
		elog "Please note that the PDF datasheets that can be linked to components from the default libraries"
		elog "cannot be mirrored by Gentoo for legal reasons."
		elog "If you want them, you need to download them yourself from :"
		elog "${HOMEPAGE}"
		elog "and install them manually."
	fi
	elog
	elog "You may want to emerge media-gfx/wings if you want to create 3D models of components."
}
