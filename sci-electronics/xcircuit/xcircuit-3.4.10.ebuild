# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-3.4.10.ebuild,v 1.3 2006/03/23 21:40:18 plasmaroo Exp $

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://opencircuitdesign.com/xcircuit/archive/${P}.tgz"
HOMEPAGE="http://opencircuitdesign.com/xcircuit"

KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="tcltk"

DEPEND="virtual/ghostscript
	tcltk? ( dev-lang/tk )
	|| ( x11-libs/libXt
	     virtual/x11
	)"

src_compile() {
	sed -i -e '693s:LDFLAGS="":LDFLAGS="-L/usr/X11R6/lib":;694i      LIBS="${LIBS} ${LIB_SPECS}"' configure.in
	aclocal && autoconf || die "Could not recreate configuration files!"

	if use tcltk; then
		econf --with-tcl --with-tk || die "econf failed"
	else
		econf || die "econf failed"
	fi

	if use tcltk; then
		sed -e '67s/extern //' -i events.c
		sed -e 's/extern Tcl_Interp/Tcl_Interp/' -i tclxcircuit.c
		sed -e '2982d; 3069d;' -i xcircuit.c
		make tcl || die
	fi
	make || die
}

src_install () {
	emake DESTDIR=${D} install || die "Installation failed"
	if use tcltk; then
		emake DESTDIR=${D} install-tcl || die "Installation failed"
	fi
	dodoc COPYRIGHT README*

	doman ${D}/usr/lib/xcircuit-3.4/man/xcircuit.1
	rm ${D}/usr/lib/xcircuit-3.4/man -rf
}
