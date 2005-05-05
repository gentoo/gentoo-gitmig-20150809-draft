# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/widelands/widelands-0.0.9.ebuild,v 1.1 2005/05/05 02:49:53 wolf31o2 Exp $

inherit games

DESCRIPTION="A game similar to Settlers 2"
HOMEPAGE="http://widelands.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-b${PV:4:4}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug"
DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-ttf
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng"

S="${WORKDIR}/${PN}"
dir="${GAMES_DATADIR}/${PN}"
Ddir=${D}/${dir}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-amd64.patch || die
}

src_compile() {
	use debug || export BUILD="release"
	emake || die "emake failed"
	unset BUILD
}

src_install() {
	dodir ${dir}
	insinto ${dir}
	exeinto ${dir}
	doins -r fonts maps pics tribes worlds campaigns README COPYING \
		|| die "copying data files"
	doexe ${PN} || die "copying widelands"
	games_make_wrapper widelands ./widelands ${dir}
	dodoc AUTHORS COPYING ChangeLog README
	prepgamesdirs
}
