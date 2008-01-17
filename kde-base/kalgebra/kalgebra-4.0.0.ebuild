# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalgebra/kalgebra-4.0.0.ebuild,v 1.1 2008/01/17 23:31:09 philantrop Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook opengl readline"

COMMONDEPEND="opengl? ( virtual/opengl )
	      readline? ( sys-libs/readline )"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

KMEXTRACTONLY=libkdeedu/kdeeduui

src_compile() {
	mycmakeargs="$(cmake-utils_use_with readline Readline)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-meta_src_compile
}

src_test() {
	sed -i -e '/functiontest/ s/^/#DONOTRUNTEST/' \
		kalgebra/src/tests/CMakeLists.txt || \
		die "Failed to disable functiontest."

	kde4-meta_src_test
}
