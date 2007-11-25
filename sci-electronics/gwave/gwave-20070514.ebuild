# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gwave/gwave-20070514.ebuild,v 1.3 2007/11/25 16:22:16 calchan Exp $

MY_P="${PN}2-${PV}"
DESCRIPTION="Analog waveform viewer for SPICE-like simulations"
LICENSE="GPL-2"
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="http://www.telltronics.org/pub/gwave/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnuplot plotutils"
SLOT="0"

DEPEND="=dev-scheme/guile-1.8*
	=x11-libs/guile-gtk-2*
	dev-scheme/guile-gnome-platform"
RDEPEND="${DEPEND}
	gnuplot? ( sci-visualization/gnuplot )
	plotutils? ( media-libs/plotutils )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix what seems to be an unintentional newline in the sources from upstream
	sed -i -e '/readline "-l$/N;s/\n//' configure || die "sed failed"

	# --as-needed fixes
	sed -i -e 's/$(LINK) \($(.*_LDFLAGS)\) \($(.*_OBJECTS) $(.*_LDADD) $(LIBS)\)/$(LINK) \2 \1/' spicefile/Makefile.in || die "sed failed"
	sed -i -e 's/_LDADD = @GTK_LIBS@/_LDADD = @GTK_LIBS@ -lX11/' remote/Makefile.in || die "sed failed"
}

src_compile() {
	econf --disable-dependency-tracking || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	rm -f doc/Makefile* *.1 || die "Removing doc/Makefile failed"
	dodoc AUTHORS NEWS README TODO || die "Installation of documentation failed"
}
