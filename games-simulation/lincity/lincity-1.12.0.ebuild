# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity/lincity-1.12.0.ebuild,v 1.1 2004/01/23 00:47:34 mr_bones_ Exp $

inherit games

DESCRIPTION="city/country simulation game for X and Linux SVGALib"
HOMEPAGE="http://lincity.sourceforge.net/"
SRC_URI="mirror://sourceforge/lincity/${P}.tar.gz"

KEYWORDS="x86 ppc amd64"
LICENSE="GPL-2"
SLOT="0"

IUSE="nls X svga"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	svga? ( media-libs/svgalib )
	X? ( virtual/x11 )
	|| ( svga? ( ) X? ( ) virtual/x11 )"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-gzip \
		`use_enable nls` \
		`use_with X x` \
		`use_with svga` \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Acknowledgements CHANGES FAQ README* TODO || die "dodoc failed"
	cd "${D}/${GAMES_DATADIR}"
	mv locale "${D}/usr/share/"
	prepgamesdirs
}
