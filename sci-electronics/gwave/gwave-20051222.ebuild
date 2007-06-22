# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gwave/gwave-20051222.ebuild,v 1.4 2007/06/22 22:30:23 dberkholz Exp $

inherit flag-o-matic

DESCRIPTION="A waveform viewer analog data, such as SPICE simulations."
LICENSE="GPL-2"
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-scheme/guile-1.6.3
	<dev-scheme/guile-1.8
	=x11-libs/guile-gtk-1.2*"

src_compile() {
	filter-ldflags -Wl,--as-needed --as-needed
	econf || die "econf failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -f doc/Makefile* *.1 || die "removing Makefile failed"
	dodoc AUTHORS NEWS README TODO doc/* || die "dodoc failed"
}
