# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/tclspice/tclspice-0.2.14.ebuild,v 1.2 2005/02/16 23:52:46 hansmi Exp $

inherit eutils

DESCRIPTION="Spice circuit simulator with TCL scripting language and GUI"
HOMEPAGE="http://tclspice.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclspice/${P}.tar.gz
	 readline? ( http://www.brorson.com/gEDA/ngspice/${P}.sdb.diff )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="readline"

DEPEND="dev-lang/tk
	>=dev-tcltk/blt-2.4z
	>=dev-tcltk/tclreadline-2.1.0"
RDEPEND="${DEPEND}
	 readline? ( sys-libs/readline )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	use readline && epatch ${DISTDIR}/${P}.sdb.diff
}

src_compile() {
	econf --enable-xspice --enable-experimental --with-tcl || die "econf failed"
	emake tcl || die
}

src_install() {
	make DESTDIR=${D} install-tcl || die
	cd ${S}
	dodoc README README.Tcl ChangeLog
	cd src/tcl
	docinto tcl
	dodoc ChangeLog README
}
