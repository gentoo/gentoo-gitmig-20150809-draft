# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclpython/tclpython-4.1.ebuild,v 1.1 2006/05/03 16:36:57 solar Exp $

inherit distutils toolchain-funcs

DESCRIPTION="a Python package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclpython.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.0
	>=virtual/python-2.2"

src_compile() {
	distutils_python_version
	$(tc-getCC) -shared -o tclpython.so.${PV} -fPIC ${CFLAGS} -Wall -I/usr/include/python${PYVER} tcl{python,thread}.c `python-config` -lpthread -lutil || die
}

src_install() {
	exeinto /usr/lib/tclpython
	doexe tclpython.so.${PV} || die "lib"
	doexe pkgIndex.tcl || die "tcl"

	dodoc CHANGES INSTALL README
	dohtml tclpython.htm
	cd ${D}/usr/lib/tclpython
	ln -sf tclpython.so.${PV} tclpython.so
}
