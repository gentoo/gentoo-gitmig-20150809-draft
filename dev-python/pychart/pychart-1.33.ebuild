# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychart/pychart-1.33.ebuild,v 1.3 2003/12/09 18:06:29 lanius Exp $


inherit distutils

MY_P=${P/pychart/PyChart}
DESCRIPTION="Python library for creating charts"
HOMEPAGE="http://www.hpl.hp.com/personal/Yasushi_Saito/pychart/"
SRC_URI="http://www.hpl.hp.com/personal/Yasushi_Saito/pychart/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/python
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
