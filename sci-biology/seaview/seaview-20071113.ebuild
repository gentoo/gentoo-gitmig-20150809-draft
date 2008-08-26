# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/seaview/seaview-20071113.ebuild,v 1.3 2008/08/26 15:08:19 ribosome Exp $

inherit toolchain-funcs multilib

DESCRIPTION="A graphical multiple sequence alignment editor"
HOMEPAGE="http://pbil.univ-lyon1.fr/software/seaview.html"

MY_PF=${PF/-/_}
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="public-domain"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/fltk
	=media-libs/pdflib-7*
	sci-biology/clustalw
	sci-biology/muscle"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"

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
		-e "s:^#HELP_NOT_IN_PATH:HELP_NOT_IN_PATH:" \
		-e "s:bge/mgouy:usr/share:" \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dobin seaview seaview_align.sh
	insinto /usr/share/${PN}
	doins protein.mase seaview.help

	insinto /usr/share/pixmaps/
	doins "${S}/${PN}.xpm"

	insinto /usr/share/applications/
	doins "${FILESDIR}/${PN}.desktop"
}
