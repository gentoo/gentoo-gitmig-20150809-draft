# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/warzone2100/warzone2100-2.0.4.ebuild,v 1.1 2006/08/27 02:27:01 mr_bones_ Exp $

inherit debug eutils versionator games

MY_PV=$(get_version_component_range -2)
DESCRIPTION="3D real-time strategy game"
HOMEPAGE="http://wz.rootzilla.de/"
SRC_URI="http://download.gna.org/warzone/releases/${MY_PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
# upstream requested debug support
IUSE="debug mp3"

RDEPEND="dev-games/physfs
	mp3? ( >=media-libs/libmad-0.15 )
	media-libs/jpeg
	media-libs/libogg
	media-libs/libpng
	media-libs/libsdl
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-net
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	app-arch/zip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e '/FilePattern/d' \
		-e "s/warzone$/${PN}/" \
		debian/${PN}.desktop || die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-ogg=/usr \
		--with-vorbis=/usr \
		--enable-ogg \
		$(use_enable mp3) \
		$(use_enable debug) \
		|| die "egamesconf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon debian/${PN}.png
	domenu debian/${PN}.desktop

	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
