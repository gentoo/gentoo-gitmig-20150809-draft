# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrex/pyrex-0.7.1.ebuild,v 1.1 2003/04/19 14:07:33 liquidx Exp $

inherit distutils

MY_P="Pyrex-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="a language for writing Python extension modules."
SRC_URI="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex/${MY_P}.tar.gz"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex"
LICENSE="as-is"

DEPEND="virtual/python"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install () {
	mydoc="CHANGES.txt INSTALL.txt README.txt USAGE.txt"
	distutils_src_install
	
	dodir /usr/share/doc/${PF}/Demos
	cp -r ${S}/Demos ${D}/usr/share/doc/${PF}
	dohtml -r Doc/*
	cp ${S}/Doc/primes.c ${D}usr/share/doc/${PF}/html/
}
