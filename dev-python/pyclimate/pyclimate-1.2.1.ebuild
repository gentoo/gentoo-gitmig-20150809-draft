# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclimate/pyclimate-1.2.1.ebuild,v 1.4 2004/07/24 00:38:34 kloeri Exp $

inherit eutils

MY_P="${P/pyclimate/PyClimate}"
S=${WORKDIR}/${MY_P}

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
	python setup.py install --prefix=${D}/usr || die "Python Install Failed"

	dodoc README PKG-INFO

	dodir /usr/share/doc/${PF}/doc
	insinto /usr/share/doc/${PF}/doc
	doins doc/*

	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
