# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclreadline/tclreadline-2.1.0.ebuild,v 1.11 2004/06/25 02:09:29 agriffis Exp $

IUSE=""
DESCRIPTION="readline extension to TCL"
HOMEPAGE="http://tclreadline.sf.net/"
SRC_URI="mirror://sourceforge/tclreadline/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha"
DEPEND=">=dev-lang/tcl-8.3*
		sys-libs/readline"

src_compile() {
	econf || die "./configure failed"
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install
}

