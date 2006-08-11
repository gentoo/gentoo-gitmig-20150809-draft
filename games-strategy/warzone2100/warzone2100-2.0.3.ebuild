# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/warzone2100/warzone2100-2.0.3.ebuild,v 1.4 2006/08/11 20:38:22 wolf31o2 Exp $

inherit debug eutils versionator games

MY_PV="$(get_version_component_range -2 ${PV})"
DESCRIPTION="3D real-time strategy game"
HOMEPAGE="http://wz.rootzilla.de/"
SRC_URI="http://download.gna.org/warzone/releases/${MY_PV}/warzone-${PV}.tar.bz2"

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

S=${WORKDIR}/warzone-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-16bpp.patch"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-ogg \
		$(use_with mp3) \
		$(use_enable debug) \
		|| die "egamesconf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon debian/${PN}.png
	domenu debian/warzone.desktop

	dodoc AUTHORS CHANGELOG README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "Currently, attempting to use uppercase letters in save game names"
	ewarn "will cause a crash."
}
