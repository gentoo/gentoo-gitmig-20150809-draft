# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/kicad/kicad-20090320.1666-r2.ebuild,v 1.5 2010/12/23 08:46:59 jlec Exp $

EAPI="2"
WX_GTK_VER="2.8"

inherit versionator wxwidgets cmake-utils

MY_PV="$(get_major_version)-r$(get_after_major_version)"

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://kicad.sourceforge.net"
SRC_URI="
	http://dev.gentoo.org/~calchan/distfiles/${PN}-sources-${MY_PV}.tar.lzma
	!minimal? ( http://dev.gentoo.org/~calchan/distfiles/${PN}-library-${MY_PV}.tar.lzma )
	doc? ( http://dev.gentoo.org/~calchan/distfiles/${PN}-doc-${MY_PV}.tar.lzma )
	examples? ( http://dev.gentoo.org/~calchan/distfiles/${PN}-examples-${MY_PV}.tar.lzma )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc debug examples minimal python"

CDEPEND="x11-libs/wxGTK:2.8[X,opengl]
	sys-libs/zlib
	dev-libs/boost[python?]"
DEPEND="${CDEPEND}
	|| ( app-arch/xz-utils app-arch/lzma-utils )"
RDEPEND="${CDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	if use doc ; then
		# Fix where kicad looks for help files
		sed -i -e "s/subdirs.Add( wxT( \"kicad\" ) );/subdirs.Add( wxT( \"${PF}\" ) );/" \
			-e '/subdirs.Add( _T( "help" ) );/d' common/edaappl.cpp \
			 || die "sed failed"
	else
		sed -i -e '/add_subdirectory(kicad-doc)/d' CMakeLists.txt || die "sed failed"
	fi
	if ! use examples ; then
		sed -i -e '/add_subdirectory(demos)/d' CMakeLists.txt || die "sed failed"
	fi
	if use minimal ; then
		sed -i -e '/add_subdirectory(kicad-library)/d' CMakeLists.txt || die "sed failed"
	fi
}

src_configure() {
	need-wxwidgets unicode

	mycmakeargs="${mycmakeargs}
		-DKICAD_CYRILLIC=ON
		-DwxUSE_UNICODE=ON
		$(cmake-utils_use python KICAD_PYTHON)
		-DKICAD_DOCS=/usr/share/doc/${PF}
		-DKICAD_HELP=/usr/share/doc/${PF}"

	cmake-utils_src_configure
}

pkg_postinst() {
	if use minimal ; then
		ewarn "If the schematic and/or board editors complain about missing libraries when you"
		ewarn "open old projects, you will have to take one or more of the following actions :"
		ewarn "- Install the missing libraries manually."
		ewarn "- Remove the libraries from the 'Libs and Dir' preferences."
		ewarn "- Fix the libraries' locations in the 'Libs and Dir' preferences."
		ewarn "- Emerge kicad without the 'minimal' USE flag."
		elog
	fi
	elog "You may want to emerge media-gfx/wings if you want to create 3D models of components."
}
