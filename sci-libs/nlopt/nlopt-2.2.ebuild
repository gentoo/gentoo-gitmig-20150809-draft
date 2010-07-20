# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/nlopt/nlopt-2.2.ebuild,v 1.2 2010/07/20 19:58:31 bicatali Exp $

EAPI=3
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="python? *"
inherit eutils python

DESCRIPTION="Non-linear optimization library"
HOMEPAGE="http://ab-initio.mit.edu/nlopt/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="LGPL-2.1 MIT"
KEYWORDS="~amd64 ~x86"

SLOT="0"
IUSE="cxx guile octave python static-libs"

DEPEND="guile? ( dev-scheme/guile )
	octave? ( sci-mathematics/octave )
	python? ( dev-python/numpy )"
RDEPEND="${DEPEND}"

src_prepare() {
	if use python; then
		sed -i \
			-e '/^LTLIBRARIES/s:$(pyexec_LTLIBRARIES)::g' \
			swig/Makefile.in || die
		echo '#!/bin/sh' > py-compile
	fi
}

src_configure() {
	if use octave; then
		export OCT_INSTALL_DIR="${EPREFIX}"/usr/libexec/octave/site/oct/${CHOST}
		export M_INSTALL_DIR="${EPREFIX}"/usr/share/octave/site/m
	else
		export MKOCTFILE=None
	fi
	econf \
		--enable-shared \
		$(use_enable static-libs static) \
		$(use_with cxx) \
		$(use_with guile) \
		$(use_with octave) \
		$(use_with python)
}

src_compile() {
	default
	if use python; then
		python_copy_sources swig
		compilation() {
			emake \
				PYTHON_CPPFLAGS="-I$(python_get_includedir)" \
				PYTHON_LDFLAGS="$(python_get_library -l)" \
				PYTHON_SITE_PKG="$(python_get_sitedir)" \
				PYTHON_VERSION="$(python_get_version)" \
				pyexecdir="$(python_get_sitedir)" \
				_nlopt.la
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

	dodoc AUTHORS ChangeLog NEWS README
	for r in */README; do newdoc ${r} README.$(dirname ${r}); done
}

pkg_postinst() {
	use python && python_mod_optimize ${PN}.py
}

pkg_postrm() {
	use python && python_mod_cleanup ${PN}.py
}
