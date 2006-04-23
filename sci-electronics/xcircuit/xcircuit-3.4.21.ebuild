# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-3.4.21.ebuild,v 1.1 2006/04/23 21:52:14 calchan Exp $

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://opencircuitdesign.com/xcircuit/archive/${P}.tgz"
HOMEPAGE="http://opencircuitdesign.com/xcircuit"

KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/ghostscript
	dev-lang/tk
	|| ( x11-libs/libXt
	     virtual/x11
	)"

src_compile() {
	econf || die 'econf failed!'
	emake tcl || die 'emake tcl failed!'
	emake || die 'emake failed!'
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
