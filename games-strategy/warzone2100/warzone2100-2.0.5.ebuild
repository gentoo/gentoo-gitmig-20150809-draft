# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/warzone2100/warzone2100-2.0.5.ebuild,v 1.1 2006/12/25 06:41:05 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools debug versionator games

MY_PV=$(get_version_component_range -2)
DESCRIPTION="3D real-time strategy game"
HOMEPAGE="http://wz2100.net/"
SRC_URI="http://download.gna.org/warzone/releases/${MY_PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
# upstream requested debug support
IUSE="debug mp3"

RDEPEND="dev-games/physfs
	media-libs/jpeg
	media-libs/libogg
	media-libs/libpng
	media-libs/libsdl
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-net
	virtual/glu
	virtual/opengl
	mp3? ( media-libs/libmad )"
DEPEND="${RDEPEND}
	app-arch/zip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(datadir):/usr/share:' Makefile.am || die "sed failed"
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
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
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
