# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclpython/tclpython-4.1-r2.ebuild,v 1.1 2010/03/31 21:03:25 jlec Exp $

PYTHON_DEPEND="2"

inherit distutils multilib toolchain-funcs

DESCRIPTION="Python package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclpython.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4"

src_compile() {
	einfo \
		"$(tc-getCC) -shared ${LDFLAGS} -fPIC ${CFLAGS} -o tclpython.so.${PV} \
		-I$(python_get_includedir) tclpython.c -lpthread -lutil"

	$(tc-getCC) -shared ${LDFLAGS} -fPIC ${CFLAGS} -o tclpython.so.${PV} \
		-I$(python_get_includedir) tclpython.c -lpthread -lutil \
		|| die
}

src_install() {
	exeinto /usr/$(get_libdir)/tclpython
	doexe tclpython.so.${PV} pkgIndex.tcl || die "tcl"
	dosym tclpython.so.${PV} /usr/$(get_libdir)/tclpython/tclpython.so || die

	dodoc CHANGES INSTALL README || die
	dohtml tclpython.htm || die
}
