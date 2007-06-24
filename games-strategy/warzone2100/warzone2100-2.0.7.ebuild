# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/warzone2100/warzone2100-2.0.7.ebuild,v 1.1 2007/06/24 23:12:15 nyhm Exp $

inherit eutils versionator games

MY_PV=$(get_version_component_range -2)
DESCRIPTION="3D real-time strategy game"
HOMEPAGE="http://wz2100.net/"
SRC_URI="http://download.gna.org/warzone/releases/${MY_PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
# upstream requested debug support
IUSE="debug mp3"

RDEPEND="dev-games/physfs
	media-libs/jpeg
	media-libs/libogg
	media-libs/libpng
	media-libs/libsdl
	media-libs/libvorbis
	>=media-libs/openal-0.0.8-r1
	media-libs/sdl-net
	virtual/glu
	virtual/opengl
	mp3? ( media-libs/libmad )"
DEPEND="${RDEPEND}
	app-arch/zip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^dist_doc_DATA/s:COPYING.*$:TODO:' Makefile.in || die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF} \
		--with-icondir=/usr/share/pixmaps \
		--with-applicationdir=/usr/share/applications \
		--with-ogg=/usr \
		--with-vorbis=/usr \
		--enable-ogg \
		$(use_enable mp3) \
		$(use_enable debug) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
	prepgamesdirs
}
