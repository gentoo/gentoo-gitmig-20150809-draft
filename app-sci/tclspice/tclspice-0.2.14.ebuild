# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tclspice/tclspice-0.2.14.ebuild,v 1.3 2003/11/28 23:58:53 plasmaroo Exp $

DESCRIPTION="Spice circuit simulator with TCL scipting language and GUI"
HOMEPAGE="http://tclspice.sf.net/"

SRC_URI="mirror://sourceforge/tclspice/${P}.tar.gz
	 readline? ( http://www.brorson.com/gEDA/ngspice/${P}.sdb.diff )"

IUSE="readline"
LICENSE="BSD"
SLOT="0"

KEYWORDS="x86 ~sparc ~ppc ~alpha"
DEPEND="dev-lang/tk
	dev-tcltk/blt
	dev-tcltk/tclreadline"

RDEPEND="$DEPEND
	 readline? ( sys-libs/readline )"

S=${WORKDIR}/${PN}

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}

	if [ `use readline` ]; then
		epatch ${DISTDIR}/${P}.sdb.diff || die "'readline' patch failed!"
	fi

}

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
