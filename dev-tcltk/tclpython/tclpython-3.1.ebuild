# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclpython/tclpython-3.1.ebuild,v 1.4 2004/10/26 13:51:18 vapier Exp $

inherit distutils toolchain-funcs

DESCRIPTION="a Python package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclperl.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.0
	>=virtual/python-2.2"

src_compile() {
	distutils_python_version
	$(tc-getCC) -shared -o tclpython.so.${PV} -s -fPIC ${CFLAGS} -Wall -I/usr/include/python${PYVER} tclpython.c `python-config` -lpthread -lutil || die
}

src_install() {
	exeinto /usr/lib/tclpython
	doexe tclpython.so.${PV} || die "lib"
	doexe pkgIndex.tcl || die "tcl"

	dodoc CHANGES INSTALL README
	dohtml tclpython.htm
}
