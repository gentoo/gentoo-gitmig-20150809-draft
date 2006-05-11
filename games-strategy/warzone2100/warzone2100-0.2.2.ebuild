# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/warzone2100/warzone2100-0.2.2.ebuild,v 1.4 2006/05/11 15:16:44 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Warzone 2100, the 3D real-time strategy game"
HOMEPAGE="http://warzone2100.sourceforge.net/"
SRC_URI="mirror://sourceforge/warzone2100/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mp3 ogg opengl"

DEPEND=">=media-libs/libsdl-1.2.8
	>=media-libs/sdl-net-1.2.5
	opengl? ( virtual/opengl )
	|| (
		(
			|| (
				~media-libs/openal-0.0.8
				~media-libs/openal-20051024 )
			media-libs/freealut )
		~media-libs/openal-20050504 )
	ogg? ( >=media-libs/libvorbis-1.1.0 media-libs/libogg )
	mp3? ( >=media-libs/libmad-0.15 )"

src_unpack() {
	unpack ${A}

	sed -e "s:DATADIR:${GAMES_DATADIR}/${PN}/:" \
		"${FILESDIR}"/${PV}-clparse.c.patch > \
		"${T}"/${PV}-clparse.c.patch \
		|| die "sed failed"

	cd "${S}"
	sed -i \
		-e 's: -m32::' configure || die
	sed -i \
		-e 's:-m32::' makerules/common.mk || die
	epatch \
		"${T}"/${PV}-clparse.c.patch \
		"${FILESDIR}"/${P}-headers.patch
}

src_compile() {
	# $(use_with cda) ... cda disables ogg/mp3
	egamesconf \
		$(use_with opengl) \
		$(use_with ogg) \
		$(use_with mp3) \
		CFLAGS="${CFLAGS}" \
		CPPFLAGS="${CXXFLAGS}" \
		|| die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/warzone || die "do executable failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "install data failed"
	dodoc AUTHORS CHANGELOG README || "install doc failed"
	prepgamesdirs
}
