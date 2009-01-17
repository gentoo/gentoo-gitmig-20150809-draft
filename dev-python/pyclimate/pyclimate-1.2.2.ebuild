# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclimate/pyclimate-1.2.2.ebuild,v 1.1 2009/01/17 21:37:02 patrick Exp $

inherit eutils distutils

MY_P="${P/pyclimate/PyClimate}"
S="${WORKDIR}/${MY_P}"

IUSE=""
DESCRIPTION="Climate Data Analysis Module for Python"
SRC_URI="http://fisica.ehu.es/jsaenz/pyclimate_files/${MY_P}.tar.gz"
HOMEPAGE="http://www.pyclimate.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~alpha ~ia64 ~ppc ~sparc ~x86"

DEPEND="virtual/python
	dev-python/numpy
	>=dev-python/scientificpython-2.8
	>=sci-libs/netcdf-3.0"

src_install() {

	distutils_src_install

	dodir /usr/share/doc/${PF}/doc
	insinto /usr/share/doc/${PF}/doc
	doins doc/*
	doins doc/dcdflib_doc/dcdflib*

	dodir /usr/share/${PF}/examples
	insinto /usr/share/${PF}/examples
	doins examples/*

	dodir /usr/share/${PF}/test
	insinto /usr/share/${PF}/test
	doins test/*
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/pyclimate
	elog
	elog "Try the test script in /usr/share/${PF}/test."
	elog "See the examples in /usr/share/${PF}/examples."
	elog "Read the doc in /usr/share/doc/${PF}."
	elog
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
