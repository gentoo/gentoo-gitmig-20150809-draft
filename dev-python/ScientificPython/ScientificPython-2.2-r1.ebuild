# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ScientificPython/ScientificPython-2.2-r1.ebuild,v 1.11 2003/06/22 12:15:59 liquidx Exp $

inherit distutils

IUSE=""
DESCRIPTION="Scientific Module for Python"
SRC_URI="http://starship.python.net/crew/hinsen/${P}.tar.gz"
HOMEPAGE="http://starship.python.net/crew/hinsen/scientific.html"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc alpha"

DEPEND="virtual/python
	>=dev-python/Numeric-19.0
	>=app-sci/netcdf-3.0"


src_install() {
	distutils_src_install
	
	dodoc MANIFEST.in COPYRIGHT README*
	cd Doc
	dodoc CHANGELOG
	dohtml HTML/*

	dodir /usr/share/doc/${PF}/pdf
	insinto /usr/share/doc/${PF}/pdf
	doins PDF/*
}
