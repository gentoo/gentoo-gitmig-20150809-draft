# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.0.29.1.ebuild,v 1.6 2010/05/24 15:45:55 tupone Exp $

EAPI=2
inherit eutils games

MUSIC=tmwmusic-0.0.20
DESCRIPTION="A fully free and open source MMORPG game with the looks of \"old-fashioned\" 2D RPG"
HOMEPAGE="http://themanaworld.org/"
SRC_URI="mirror://sourceforge/themanaworld/${P}.tar.gz
	mirror://sourceforge/themanaworld/${MUSIC}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls opengl"

RDEPEND=">=dev-games/physfs-1.0.0
	dev-libs/libxml2
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	media-libs/sdl-ttf
	net-misc/curl
	sys-libs/zlib
	media-libs/libpng
	media-fonts/dejavu
	>=dev-games/guichan-0.8.1[sdl]
	nls? ( virtual/libintl )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e '/^SUBDIRS/s/fonts//' \
		data/Makefile.in \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-desktop.patch \
		"${FILESDIR}"/${P}-gcc45.patch
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		$(use_enable nls) \
		$(use_with opengl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans.ttf
	cd "${WORKDIR}"
	insinto "${GAMES_DATADIR}"/${PN}/data/music
	doins ${MUSIC}/data/music/*.ogg || die
	newdoc ${MUSIC}/README README.music
	prepgamesdirs
}
