# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xcircuit/xcircuit-3.1.31.ebuild,v 1.1 2004/01/05 13:12:30 plasmaroo Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://xcircuit.ece.jhu.edu/archive/${P}.tgz"
HOMEPAGE="http://xcircuit.ece.jhu.edu"

KEYWORDS="x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/x11
	virtual/ghostscript
	tcltk? ( dev-lang/tk )"

src_compile() {

	sed -e '693s:LDFLAGS="":LDFLAGS="-L/usr/X11R6/lib":;694i      LIBS="${LIBS} ${LIB_SPECS}"' -i configure.in
	aclocal && autoconf || die "Could not recreate configuration files!"

	if [ `use tcltk` ]; then
		econf --with-tcl --with-tk
	else
		econf
	fi

	if [ `use tcltk` ]; then
		sed -e '67s/extern //' -i events.c
		sed -e 's/extern Tcl_Interp/Tcl_Interp/' -i tclxcircuit.c
		sed -e '2982d; 3069d;' -i xcircuit.c
		make tcl || die
	fi
	make || die

}

src_install () {

	emake DESTDIR=${D} install || die "Installation failed"
	if [ `use tcltk` ]; then
		emake DESTDIR=${D} install-tcl || die "Installation failed"
	fi
	dodoc COPYRIGHT README*

}
