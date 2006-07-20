# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/warzone2100/warzone2100-2.0.3.ebuild,v 1.2 2006/07/20 21:57:50 mr_bones_ Exp $

inherit eutils versionator games

MY_PV="$(get_version_component_range -2 ${PV})"
DESCRIPTION="3D real-time strategy game"
HOMEPAGE="http://home.gna.org/warzone/"
SRC_URI="http://download.gna.org/warzone/releases/${MY_PV}/warzone-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-games/physfs
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

	sed -i \
		-e 's/-m32 //' \
		configure \
		|| die "sed failed"
	epatch "${FILESDIR}/${P}-16bpp.patch"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-ogg \
		--without-mp3 \
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
