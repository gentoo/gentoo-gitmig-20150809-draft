# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnuplot-py/gnuplot-py-1.7-r2.ebuild,v 1.5 2008/01/24 18:34:38 nixnut Exp $

inherit distutils eutils

DESCRIPTION="A python wrapper for Gnuplot"
HOMEPAGE="http://gnuplot-py.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/python
	sci-visualization/gnuplot
	dev-python/numpy"

PYTHON_MODNAME="Gnuplot"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-numpy.patch"
	epatch "${FILESDIR}/${P}-mousesupport.patch"
}

src_install() {
	distutils_src_install
	dohtml doc/Gnuplot/*
	insinto /usr/share/doc/${PF}
	doins demo.py
}
