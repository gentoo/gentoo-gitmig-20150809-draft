# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclpython/tclpython-3.1.ebuild,v 1.3 2004/10/17 10:14:24 dholm Exp $

inherit distutils

DESCRIPTION="a Python package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclperl.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/tcl-8.0
	>=virtual/python-2.2"

src_compile() {
	distutils_python_version
	${CC} -shared -o tclpython.so.${PV} -s -fPIC ${CFLAGS} -Wall -I/usr/include/python${PYVER} tclpython.c `python-config` -lpthread -lutil || die
}

src_install() {
	insinto /usr/lib/tclpython
	doins tclpython.so.${PV}
	doins pkgIndex.tcl

	dodoc CHANGES INSTALL README
	dohtml tclpython.htm
}
