# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gwave/gwave-20060606.ebuild,v 1.2 2009/10/04 15:16:25 ssuominen Exp $

inherit flag-o-matic

DESCRIPTION="Analog waveform viewer for SPICE-like simulations"
LICENSE="GPL-2"
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnuplot plotutils"
SLOT="0"

DEPEND="=dev-scheme/guile-1.6*
	=x11-libs/guile-gtk-1.2*"
RDEPEND="${DEPEND}
	gnuplot? ( sci-visualization/gnuplot )
	plotutils? ( media-libs/plotutils )"

src_compile() {
	append-ldflags $(no-as-needed)
	econf --disable-dependency-tracking || die "Configuration failed"
	make || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	rm -f doc/Makefile* *.1 || die "Removing doc/Makefile failed"
	dodoc AUTHORS NEWS README TODO doc/* || die "Installation of documentation failed"
}
