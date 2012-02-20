# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/visual/visual-5.72.ebuild,v 1.4 2012/02/20 14:33:11 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-**"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit flag-o-matic multilib python versionator

MY_P="${PN}-$(delete_version_separator 2)_release"

DESCRIPTION="Real-time 3D graphics library for Python"
HOMEPAGE="http://www.vpython.org/"
SRC_URI="http://www.vpython.org/contents/download/${MY_P}.tar.bz2"

IUSE="doc examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="visual"

RDEPEND="<dev-libs/boost-1.48[python]
	dev-cpp/libglademm
	>=dev-cpp/gtkglextmm-1.2
	dev-python/numpy
	dev-python/polygon
	dev-python/ttfquery"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# redundant file
	rm src/gtk2/random_device.cpp || die
	sed -i \
		-e 's/random_device.lo//g' \
		src/Makefile.in src/gtk2/makefile || die
	# verbose build
	sed -i -e 's/2\?>> \?\$(LOGFILE).*//' src/Makefile.in || die

	echo "#!/bin/bash" > py-compile
	python_src_prepare
}

src_configure() {
	BOOST_PKG="$(best_version ">=dev-libs/boost-1.41.0")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="${EPREFIX}/usr/include/boost-${BOOST_VER}"
	BOOST_LIB="${EPREFIX}/usr/$(get_libdir)/boost-${BOOST_VER}"

	# hack to specify the include and lib directory for boost
	append-cxxflags -I${BOOST_INC}
	append-ldflags -L${BOOST_LIB}

	python_src_configure \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--with-example-dir="${EPREFIX}/usr/share/doc/${PF}/examples" \
		$(use_enable doc docs) \
		$(use_enable examples)
}

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc authors.txt HACKING.txt NEWS.txt || die "dodoc failed"
	# Don't install useless vpython script.
	rm -fr "${ED}usr/bin"
}

pkg_postinst() {
	python_mod_optimize vis visual
}

pkg_postrm() {
	python_mod_cleanup vis visual
}
