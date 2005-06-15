# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/widelands/widelands-0.0.9.ebuild,v 1.3 2005/06/15 19:22:10 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="A game similar to Settlers 2"
HOMEPAGE="http://widelands.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-b${PV:4:4}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-ttf
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-amd64.patch"
}

src_compile() {
	use debug || export BUILD="release"
	emake || die "emake failed"
	unset BUILD
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}

	insinto "${dir}"
	doins -r fonts maps pics tribes worlds campaigns README \
		|| die "doins failed"
	exeinto "${dir}"
	doexe ${PN} || die "copying widelands"
	games_make_wrapper widelands ./widelands "${dir}"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
