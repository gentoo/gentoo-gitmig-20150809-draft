# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/seaview/seaview-20041220.ebuild,v 1.2 2005/01/30 18:21:09 ribosome Exp $

DESCRIPTION="A graphical multiple sequence alignment editor"
HOMEPAGE="http://pbil.univ-lyon1.fr/software/seaview.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="x11-libs/fltk
	sci-biology/clustalw"

src_compile() {
	# Corrects location of libfltk.
	CFLAGS="${CFLAGS} -c -I/usr/include/fltk-1.1"
	sed -i -e "s%\"seaview.help\", %\"/usr/share/${PN}/seaview.help\", %" seaview.cxx || die
	sed -i -e 's:-L$(FLTK)/lib:-L/usr/lib/fltk-1.1:' Makefile || die

	emake -e || die
}

src_install() {
	dobin seaview seaview_align.sh
	insinto /usr/share/${PN}
	doins protein.mase seaview.help
}
