# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.3.ebuild,v 1.9 2005/03/27 03:54:30 matsuu Exp $

IUSE="X"

DESCRIPTION="Tcl Standard Library."
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="mirror://sourceforge/tcllib/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips amd64 ~ia64"

DEPEND=">=dev-lang/tcl-8.3.3
	X? ( >=dev-lang/tk-8.3.3 )"

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die

	dodoc ChangeLog README license.terms
	dohtml -r doc/html/*
}
