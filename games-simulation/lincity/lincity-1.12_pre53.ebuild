# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity/lincity-1.12_pre53.ebuild,v 1.6 2004/07/01 11:24:07 eradicator Exp $

inherit games

MY_P=${P/_}
DESCRIPTION="city/country simulation game for X and Linux SVGALib"
SRC_URI="mirror://sourceforge/lincity/${MY_P}.tar.gz"
HOMEPAGE="http://lincity.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="X svga"

DEPEND="virtual/libc
	|| (
		svga? ( media-libs/svgalib )
		X? ( virtual/x11 )
		virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_compile() {
	egamesconf \
		--with-gzip \
		`use_with X x` \
		`use_with svga` \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc Acknowledgements CHANGES FAQ README* TODO
	cd ${D}/${GAMES_DATADIR}
	mv locale ${D}/usr/share/
	prepgamesdirs
}
