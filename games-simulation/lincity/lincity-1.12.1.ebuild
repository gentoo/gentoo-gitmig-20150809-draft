# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity/lincity-1.12.1.ebuild,v 1.5 2006/02/22 21:59:02 tupone Exp $

inherit games

DESCRIPTION="city/country simulation game for X and Linux SVGALib"
HOMEPAGE="http://lincity.sourceforge.net/"
SRC_URI="mirror://sourceforge/lincity/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos ~sparc x86"
IUSE="nls svga X"

# dep fix (bug #82318)
DEPEND="
	nls? ( sys-devel/gettext )
	svga? ( media-libs/svgalib )
	X? (
			|| (
				(
					x11-libs/libXext
					x11-libs/libSM
				)
				virtual/x11
			)
		)
	!svga? (
			|| (
				(
					x11-libs/libXext
					x11-libs/libSM
				)
				virtual/x11
			)
		)"

src_compile() {
	local myconf=

	if ! use X && ! use svga ; then
		myconf="--with-x"
	fi
	egamesconf \
		--disable-dependency-tracking \
		--with-gzip \
		$(use_enable nls) \
		$(use_with svga) \
		$(use_with X x) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Acknowledgements CHANGES README* TODO || die "dodoc failed"
	if use nls ; then
		cd "${D}/${GAMES_DATADIR}"
		mv locale "${D}/usr/share/"
	fi
	prepgamesdirs
}
