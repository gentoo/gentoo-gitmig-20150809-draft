# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tclspice/tclspice-0.2.14.ebuild,v 1.1 2003/08/31 14:04:25 cretin Exp $

DESCRIPTION="Spice circuit simulator with TCL scipting language and GUI"

HOMEPAGE="http://tclspice.sf.net/"

SRC_URI="mirror://sourceforge/tclspice/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="x86 ~sparc ~ppc ~alpha"

IUSE=""

DEPEND="dev-lang/tk
		dev-tcltk/blt
		dev-tcltk/tclreadline"

S=${WORKDIR}/${PN}

src_compile() {
	econf --enable-xspice --enable-experimental --with-tcl
	emake tcl || die
}

src_install() {
	make DESTDIR=${D} install-tcl || die
	cd ${S}
	dodoc README README.Tcl ChangeLog
	cd src/tcl
	docinto tcl
	dodoc ChangeLog  README
}
