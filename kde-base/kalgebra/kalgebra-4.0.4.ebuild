# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalgebra/kalgebra-4.0.4.ebuild,v 1.1 2008/05/15 22:41:35 ingmar Exp $

EAPI="1"

KMNAME=kdeedu
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook opengl readline"

DEPEND="opengl? ( virtual/opengl )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdeedu/kdeeduui

# Needed for USE="-opengl"
PATCHES="${FILESDIR}/${PN}-4.0.2-opengl.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with readline Readline)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_compile
}

src_test() {
# Miraculously, the tests seem to have been fixed. Leaving this in for now, though.
#	sed -i -e '/functiontest/ s/^/#DONOTRUNTEST/' \
#		kalgebra/src/tests/CMakeLists.txt || \
#		die "Failed to disable functiontest."

	kde4-meta_src_test
}
