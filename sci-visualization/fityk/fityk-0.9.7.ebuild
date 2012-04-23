# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/fityk/fityk-0.9.7.ebuild,v 1.2 2012/04/23 17:29:33 mgorny Exp $

EAPI="3"

WX_GTK_VER="2.8"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"

inherit python wxwidgets

DESCRIPTION="General-purpose nonlinear curve fitting and data analysis"
HOMEPAGE="http://fityk.nieto.pl/"
SRC_URI="mirror://github/wojdyr/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples gnuplot lua readline python static-libs wxwidgets"

CDEPEND=">=sci-libs/xylib-0.8
	lua? ( dev-lang/lua )
	readline? ( sys-libs/readline )
	wxwidgets? ( x11-libs/wxGTK:2.8 )"

DEPEND="${CDEPEND}
	dev-libs/boost
	>=sys-devel/libtool-2.2"

RDEPEND="${CDEPEND}
	gnuplot? ( sci-visualization/gnuplot )"

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	has_version "<dev-libs/boost-1.37" && \
		sed -i -e 's:impl/directives.hpp:directives.ipp:g' \
		"${S}/src/optional_suffix.h"

	sed '/^LTLIBRARIES/s:$(pyexec_LTLIBRARIES)::g' \
		-i swig/Makefile.in
	if use python; then
		echo '#!/bin/sh' > config/py-compile
	fi
}

src_configure() {
	econf  \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--disable-xyconvert \
		$(use_enable lua) \
		$(use_enable python) \
		$(use_enable static-libs static) \
		$(use_enable wxwidgets GUI) \
		$(use_with doc) \
		$(use_with examples samples) \
		$(use_with readline)
}

src_compile() {
	use python && python_copy_sources swig
	default
	if use python; then
		compilation() {
			emake \
				PYTHON_CPPFLAGS="-I$(python_get_includedir)" \
				PYTHON_LDFLAGS="$(python_get_library -l)" \
				PYTHON_SITE_PKG="$(python_get_sitedir)" \
				PYTHON_VERSION="$(python_get_version)" \
				pyexecdir="$(python_get_sitedir)" \
				_fityk.la
		}
		python_execute_function -s --source-dir swig compilation
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_execute_function -s --source-dir swig installation
		python_clean_installation_image
	fi
	dodoc NEWS README TODO
}

pkg_postinst() {
	use python && python_mod_optimize ${PN}.py
}

pkg_postrm() {
	use python && python_mod_cleanup ${PN}.py
}
