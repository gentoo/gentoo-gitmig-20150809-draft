# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gwave/gwave-20031224.ebuild,v 1.9 2011/03/02 21:41:19 jlec Exp $

EAPI="1"

DESCRIPTION="A waveform viewer analog data, such as SPICE simulations"
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE=""
SLOT="0"

DEPEND="
	x11-libs/gtk+:1
	>=dev-scheme/guile-1.6.3
	<dev-scheme/guile-1.8
	=x11-libs/guile-gtk-1.2*"

src_compile() {
	econf || die "econf failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -f doc/Makefile* *.1 || die "removing Makefile failed"
	dodoc AUTHORS INSTALL NEWS README TODO doc/* || die "dodoc failed"
}
