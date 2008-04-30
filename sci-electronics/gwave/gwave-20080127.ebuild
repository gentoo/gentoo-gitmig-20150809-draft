# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gwave/gwave-20080127.ebuild,v 1.2 2008/04/30 18:10:45 calchan Exp $

inherit flag-o-matic

DESCRIPTION="Analog waveform viewer for SPICE-like simulations"
LICENSE="GPL-2"
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnuplot plotutils"
SLOT="0"

DEPEND="=dev-scheme/guile-1.8*
	=x11-libs/guile-gtk-1.2.0.60"
RDEPEND="${DEPEND}
	gnuplot? ( sci-visualization/gnuplot )
	plotutils? ( media-libs/plotutils )"

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	rm -f doc/Makefile* *.1 || die "Removing doc/Makefile failed"
	dodoc AUTHORS NEWS README TODO doc/* || die "Installation of documentation failed"
}
