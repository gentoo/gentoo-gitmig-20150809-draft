# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/orbital-eunuchs-sniper/orbital-eunuchs-sniper-1.30.ebuild,v 1.2 2007/04/05 23:48:57 nyhm Exp $

inherit autotools eutils games

MY_P=${PN//-/_}-${PV}
DESCRIPTION="Snipe terrorists from your orbital base"
HOMEPAGE="http://icculus.org/oes/"
SRC_URI="http://filesingularity.timedoctor.org/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-datadir.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog readme.txt README TODO
	prepgamesdirs
}
