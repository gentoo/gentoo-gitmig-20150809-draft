# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclpython/tclpython-3.1-r1.ebuild,v 1.3 2010/04/12 13:37:16 phajdan.jr Exp $

PYTHON_DEPEND="2"

inherit distutils multilib toolchain-funcs

DESCRIPTION="Python package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclpython.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4"

src_compile() {
	cfile="tclpython"
	for src in ${cfile}; do
		compile="$(tc-getCC) -shared -fPIC ${CFLAGS} -I$(python_get_includedir) -c ${src}.c"
		einfo "${compile}"
		eval "${compile}" || die
	done

	link="$(tc-getCC) -fPIC -shared ${LDFLAGS} -o tclpython.so.${PV} tclpython.o -lpthread -lutil $(python_get_library -l) -ltcl"

	einfo "${link}"

	eval "${link}" || die
}

src_install() {
	exeinto /usr/$(get_libdir)/tclpython
	doexe tclpython.so.${PV} pkgIndex.tcl || die "tcl"
	dosym tclpython.so.${PV} /usr/$(get_libdir)/tclpython/tclpython.so || die

	dodoc CHANGES INSTALL README || die
	dohtml tclpython.htm || die
}
