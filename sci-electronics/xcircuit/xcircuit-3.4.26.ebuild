# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-3.4.26.ebuild,v 1.1 2006/07/22 16:48:28 calchan Exp $

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://opencircuitdesign.com/xcircuit/archive/${P}.tgz"
HOMEPAGE="http://opencircuitdesign.com/xcircuit"

KEYWORDS="~amd64 ~ppc ~x86"
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
