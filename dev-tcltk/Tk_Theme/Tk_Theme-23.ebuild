# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/Tk_Theme/Tk_Theme-23.ebuild,v 1.8 2004/04/03 21:16:07 spyderous Exp $

DESCRIPTION="Theming library for TCL/TK."
HOMEPAGE="http://www.xmission.com/~georgeps/Tk_Theme/"
SRC_URI="http://www.xmission.com/~georgeps/Tk_Theme/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-lang/tcl
	dev-lang/tk
	virtual/x11"

src_compile() {
	tclsh configure || die
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
