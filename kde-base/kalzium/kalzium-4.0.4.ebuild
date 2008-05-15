# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalzium/kalzium-4.0.4.ebuild,v 1.1 2008/05/15 22:42:23 ingmar Exp $

EAPI="1"

KMNAME=kdeedu
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE: periodic table of the elements."
KEYWORDS="~amd64 ~x86"
IUSE="${IUSE} cviewer debug htmlhandbook solver"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
	cviewer? ( >=dev-cpp/eigen-1.0.5
		>=sci-chemistry/openbabel-2.1
		|| ( x11-libs/qt-opengl:4
			>=x11-libs/qt-4.3.3:4 )
		virtual/opengl )"
DEPEND="${DEPEND} ${COMMONDEPEND}
	solver? ( dev-ml/facile )"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/libscience"

pkg_setup() {
	if use cviewer && has_version '<x11-libs/qt-4.4.0_alpha:4'; then
		QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK} opengl"
	fi

	if use solver && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build the solver for ${PN}, you first need"
		eerror "to have dev-lang/ocaml built with the ocamlopt useflag"
		eerror "in order to get a native code ocaml compiler"
		die "Please install dev-lang/ocaml with ocamlopt support"
	fi
	if use solver && ! built_with_use --missing true dev-ml/facile ocamlopt; then
		eerror "In order to build the solver for ${PN}, you first need"
		eerror "to have dev-ml/facile built with the ocamlopt useflag"
		eerror "in order to get the native code library"
		die "Please install dev-ml/facile with ocamlopt support"
	fi

	kde4-meta_pkg_setup
}

src_compile() {
	if use solver ; then
		# Compile the solver on its own as the cmake-based build is
		# currently broken. Fixes bug 206620.
		cd "${S}/${PN}/src/solver"
		emake || die "compiling the ocaml resolver failed"
		mkdir -p "${WORKDIR}/${PN}_build/${PN}/src/"
		cp * "${WORKDIR}/${PN}_build/${PN}/src/"
	fi

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with cviewer Eigen)
		$(cmake-utils_use_with cviewer OpenBabel2)
		$(cmake-utils_use_with cviewer OpenGL)
		$(cmake-utils_use_with solver OCaml)
		$(cmake-utils_use_with solver Libfacile)"

	kde4-meta_src_compile
}
