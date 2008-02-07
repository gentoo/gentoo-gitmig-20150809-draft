# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalgebra/kalgebra-4.0.1.ebuild,v 1.1 2008/02/07 00:12:31 philantrop Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook opengl readline"

DEPEND="opengl? ( virtual/opengl )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdeedu/kdeeduui

PATCHES="${FILESDIR}/${P}-opengl.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with readline Readline)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_compile
}

src_test() {
	sed -i -e '/functiontest/ s/^/#DONOTRUNTEST/' \
		kalgebra/src/tests/CMakeLists.txt || \
		die "Failed to disable functiontest."

	kde4-meta_src_test
}
