# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.3.ebuild,v 1.5 2004/01/15 03:58:44 agriffis Exp $

DESCRIPTION="Tcl Standard Library."
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="mirror://sourceforge/tcllib/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~alpha"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die

	dodoc ChangeLog README license.terms
	dohtml -r doc/html/*
}
