# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/Tk_Theme/Tk_Theme-23.ebuild,v 1.1 2003/02/01 22:25:03 agenkin Exp $

DESCRIPTION="Theming library for TCL/TK."
HOMEPAGE="http://www.xmission.com/~georgeps/Tk_Theme/"

DEPEND="=dev-lang/tcl-8.3*
	=dev-lang/tk-8.3*
	x11-base/xfree"

LICENSE="BSD"
KEYWORDS="~x86"

SLOT="0"
SRC_URI="http://www.xmission.com/~georgeps/Tk_Theme/${P}.tgz"
S=${WORKDIR}/${P}

src_compile() {

	tclsh8.3 configure || die
	make || die

}

src_install() {

	local libdir=/usr/lib/Tk_Theme
	
	insinto ${libdir}
	doins *.tcl
	exeinto ${libdir}
	doexe theme.so

	dodoc Changes LICENSE README TODO

}
