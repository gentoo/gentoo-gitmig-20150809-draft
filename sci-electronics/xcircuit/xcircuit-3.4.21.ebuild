# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-3.4.21.ebuild,v 1.3 2006/06/04 08:06:41 calchan Exp $

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://opencircuitdesign.com/xcircuit/archive/${P}.tgz"
HOMEPAGE="http://opencircuitdesign.com/xcircuit"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/ghostscript
	dev-lang/tk
	|| ( x11-libs/libXt
	     virtual/x11
	)"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:\$(datadir):\$(libdir):" \
		-e "s:\$(appmandir):\$(mandir)/man1:" \
		${S}/Makefile.in
}

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
}

src_test () {
	# See bug #131024
	true
}
