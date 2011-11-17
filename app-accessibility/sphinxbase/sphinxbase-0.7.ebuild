# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinxbase/sphinxbase-0.7.ebuild,v 1.1 2011/11/17 17:35:05 neurogeek Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6"
SUPPORT_PYTHON_ABIS="1"

inherit autotools-utils python

DESCRIPTION="Support library required by the Sphinx Speech Recognition Engine"
HOMEPAGE="http://cmusphinx.sourceforge.net/"
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc lapack python static-libs"

RDEPEND="lapack? ( virtual/lapack )"
DEPEND="${RDEPEND}
		doc? ( >=app-doc/doxygen-1.4.7 )"

RESTRICT_PYTHON_ABIS="3*"

src_configure() {
	econf \
		$( use_with lapack ) \
		$( use_with python ) \
		$( use_enable static-libs static )
}

src_compile() {
	default

	if use python; then
		python_copy_sources python

		building() {
			emake PYTHON="$(PYTHON)" PYTHON_INCLUDEDIR="$(python_get_includedir)" PYTHON_LIBDIR="$(python_get_libdir)"
		}

		python_execute_function -s --source-dir python building
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use python; then
		python_execute_function -s --source-dir python -d
	fi

	if use doc; then
		dohtml doc/html/*
	fi

	remove_libtool_files
}
