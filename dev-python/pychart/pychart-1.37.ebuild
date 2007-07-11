# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychart/pychart-1.37.ebuild,v 1.3 2007/07/11 06:19:47 mr_bones_ Exp $

inherit distutils

MY_P=${P/pychart/PyChart}
DESCRIPTION="Python library for creating charts"
HOMEPAGE="http://home.gna.org/pychart/"
SRC_URI="http://download.gna.org/pychart/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2
	>=sys-apps/sed-4
	virtual/ghostscript"

S=${WORKDIR}/${MY_P}
DOCS="README.txt"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/unevenbars.py//" demos/Makefile || die "sed failed on Makefile"
}

src_install() {
	distutils_src_install
	dohtml doc/pychart/*
	insinto /usr/share/doc/${PF}/demos
	doins demos/*
}
