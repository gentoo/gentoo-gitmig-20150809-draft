# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrex/pyrex-0.5.ebuild,v 1.1 2002/12/11 16:09:39 blauwers Exp $

MY_P="Pyrex-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="a language for writing Python extension modules."
SRC_URI="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex/${MY_P}.tar.gz"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex"
LICENSE="as-is"

DEPEND="virtual/python"
RDEPEND=""
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc CHANGES.txt INSTALL.txt README.txt USAGE.txt 
	dodir ${D}usr/share/doc/${PF}/Demos
	cp -r ${S}/Demos ${D}usr/share/doc/${PF}
	dohtml -r Doc/*
	cp ${S}/Doc/primes.c ${D}usr/share/doc/${PF}/html/
}
