# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-4.2.0.ebuild,v 1.1 2011/02/04 15:00:35 tampakrap Exp $

EAPI=3

# Bug 328269
RESTRICT="test"

KDE_LINGUAS="ca ca@valencia da de en_GB es et fi gl it nds nl pt pt_BR sl sv th uk zh_CN zh_TW"

KMNAME="kdevelop"
inherit kde4-base

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE="+cmake +cxx debug okteta +qmake qthelp"

DEPEND="
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep libkworkspace)
	okteta? ( $(add_kdebase_dep okteta) )
	qthelp? ( >=x11-libs/qt-assistant-4.4:4 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kapptemplate)
	cxx? ( >=sys-devel/gdb-7.0[python] )
"

src_prepare() {
	kde4-base_src_prepare

	# Remove this and the ksysguard dep after libprocessui moved into kdelibs
	sed -i -e 's/${KDE4WORKSPACE_PROCESSUI_LIBS}/processui/g' \
		debuggers/gdb/CMakeLists.txt \
		|| die "Failed to patch CMake files"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cmake)
		$(cmake-utils_use_build cmake cmakebuilder)
		$(cmake-utils_use_build cxx cpp)
		$(cmake-utils_use_with okteta LibKasten)
		$(cmake-utils_use_with okteta LibOkteta)
		$(cmake-utils_use_with okteta LibOktetaKasten)
		$(cmake-utils_use_build qmake)
		$(cmake-utils_use_build qmake qmakebuilder)
		$(cmake-utils_use_build qmake qmake_parser)
		$(cmake-utils_use_build qthelp)
	)

	kde4-base_src_configure
}
