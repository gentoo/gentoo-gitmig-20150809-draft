# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tclspice/tclspice-0.2.15.ebuild,v 1.1 2004/02/01 16:33:03 plasmaroo Exp $

DESCRIPTION="Spice circuit simulator with TCL scipting language and GUI"
HOMEPAGE="http://tclspice.sf.net/"
SRC_URI="mirror://sourceforge/tclspice/${P}.tar.gz"

IUSE=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="x86 ~sparc"
DEPEND="dev-lang/tk
	>=dev-tcltk/blt-2.4z
	>=dev-tcltk/tclreadline-2.1.0"

RDEPEND="$DEPEND
	 sys-libs/readline"

S=${WORKDIR}/${PN}
MAKEOPTS="$MAKEOPTS -j1" # Seems to get out-of-sync and break otherwise

src_compile() {

	econf --enable-xspice --enable-experimental --with-tcl || die
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
