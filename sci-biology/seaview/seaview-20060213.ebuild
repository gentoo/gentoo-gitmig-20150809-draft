# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/seaview/seaview-20060213.ebuild,v 1.2 2007/03/25 02:58:30 kugelfang Exp $

inherit toolchain-funcs multilib

DESCRIPTION="A graphical multiple sequence alignment editor"
HOMEPAGE="http://pbil.univ-lyon1.fr/software/seaview.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="x11-libs/fltk
	=media-libs/pdflib-6.0*
	sci-biology/clustalw"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s%\"seaview.help\", %\"/usr/share/${PN}/seaview.help\", %" seaview.cxx || die

	# Respect CXXFLAGS. Package uses CFLAGS as CXXFLAGS.
	# Fix invocation of C++ compiler.
	# Fix include and library paths.
	sed -i \
		-e '/^FLTK/d' \
		-e '/^X11/d' \
		-e "s:^CXX.*:CXX = $(tc-getCXX):" \
		-e 's:-I$(FLTK):-I/usr/include/fltk-1.1:' \
		-e 's:-I$(X11)/include:-I/usr/include/X11R6:' \
		-e "s:\(^CFLAGS .*\):\1 ${CXXFLAGS}:" \
		-e "s:-L\$(FLTK)/lib:-L/usr/$(get_libdir)/fltk-1.1:" \
		-e "s:-L\$(X11)/lib:-L/usr/$(get_libdir)/X11:" \
		Makefile || die
}

src_install() {
	dobin seaview seaview_align.sh
	insinto /usr/share/${PN}
	doins protein.mase seaview.help
}
