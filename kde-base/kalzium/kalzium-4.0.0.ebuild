# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-4.0.0.ebuild,v 1.1 2008/01/17 23:31:30 philantrop Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: periodic table of the elements."
KEYWORDS="~amd64 ~x86"
IUSE="cviewer debug htmlhandbook solver test"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
	cviewer? ( >=dev-cpp/eigen-1.0.5
		>=sci-chemistry/openbabel-2.1
		virtual/opengl )"
DEPEND="${DEPEND} ${COMMONDEPEND}
	solver? ( dev-ml/facile )"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/libscience"

pkg_setup() {
	use cviewer && QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} opengl"

	kde4-meta_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with cviewer Eigen)
		$(cmake-utils_use_with cviewer OpenBabel2)
		$(cmake-utils_use_with cviewer OpenGL)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with solver Libfacile)"

	kde4-meta_src_compile
}
