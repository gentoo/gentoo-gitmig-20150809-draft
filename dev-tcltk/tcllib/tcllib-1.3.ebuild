# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.3.ebuild,v 1.2 2003/03/02 03:28:36 agenkin Exp $

DESCRIPTION="Tcl Standard Library."
HOMEPAGE="http://www.tcl.tk/software/tcllib/"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

LICENSE="BSD"
KEYWORDS="x86"

SLOT="0"
SRC_URI="mirror://sourceforge/tcllib/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {

	econf || die
	make || die

}

src_install() {

	einstall || die

	dodoc ChangeLog README license.terms
	dohtml -r doc/html/*

}
