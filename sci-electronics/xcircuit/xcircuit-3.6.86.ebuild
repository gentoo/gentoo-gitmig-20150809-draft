# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-3.6.86.ebuild,v 1.1 2007/04/01 13:08:01 calchan Exp $

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://opencircuitdesign.com/xcircuit/archive/${P}.tgz"
HOMEPAGE="http://opencircuitdesign.com/xcircuit"

# This is a development version. Do not keyword without contacting maintainer as we add/remove these at random.
KEYWORDS=""
SLOT="0"
LICENSE="GPL-2"
IUSE=""

# Disable tests, see bug #131024
RESTRICT="test"

DEPEND="virtual/ghostscript
	dev-lang/tk
	|| ( x11-libs/libXt
	     virtual/x11
	)"

src_compile() {
	econf \
		--with-tcl \
		--with-ngspice \
		--disable-dependency-tracking \
		|| die 'econf failed!'
	emake || die 'emake failed!'
}

src_install () {
	make DESTDIR=${D} install || die "Installation failed"
	dodoc CHANGES README* TODO

	doman ${D}/usr/lib/xcircuit-3.6/man/xcircuit.1
	rm ${D}/usr/lib/xcircuit-3.6/man -rf
}

src_postinst() {
	ewarn "You may want to emerge ng-spice-rework which integrates well with xcircuit."
	ewarn "Note that in order for ngspice to work with xcircuit, you'll need at least"
	ewarn "sci-electronics/ng-spice-rework-17-r1."
}
