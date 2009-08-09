# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-3.4.18.ebuild,v 1.11 2009/08/09 10:28:22 ssuominen Exp $

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://opencircuitdesign.com/xcircuit/archive/${P}.tgz"
HOMEPAGE="http://opencircuitdesign.com/xcircuit"

KEYWORDS="amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="virtual/ghostscript
	<dev-lang/tk-8.5
	x11-libs/libXt"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:\$(datadir):\$(libdir):" \
		-e "s:\$(appmandir):\$(mandir)/man1:" \
		"${S}"/Makefile.in
}

src_compile() {
	econf \
	--with-tcl \
	--with-ngspice \
	--disable-dependency-tracking \
	|| die 'econf failed!'
	emake CFLAGS="${CFLAGS} -fPIC" || die 'emake failed!'
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc CHANGES README* TODO
}

src_test () {
	# See bug #131024
	true
}
