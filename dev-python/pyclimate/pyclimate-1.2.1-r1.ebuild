# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclimate/pyclimate-1.2.1-r1.ebuild,v 1.3 2004/07/20 19:26:39 kloeri Exp $

inherit eutils distutils

MY_P="${P/pyclimate/PyCLimate}"
IUSE=""
DESCRIPTION="Climate Data Analysis Module for Python"
SRC_URI="http://starship.python.net/crew/jsaenz/pyclimate/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://starship.python.net/crew/jsaenz/pyclimate/index.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"

DEPEND="virtual/python
	>=dev-python/numeric-19.0
	dev-python/scientificpython
	>=app-sci/netcdf-3.0"

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
	einfo
	einfo "Try the test script in /usr/share/${PF}/test."
	einfo "See the examples in /usr/share/${PF}/examples."
	einfo "Read the doc in /usr/share/doc/${PF}."
	einfo
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
