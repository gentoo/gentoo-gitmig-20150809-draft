# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/naev/naev-0.4.2.ebuild,v 1.3 2010/04/27 15:30:36 ssuominen Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A 2D space trading and combat game, in a similar vein to Escape Velocity"
HOMEPAGE="http://code.google.com/p/naev/"
SRC_URI="http://naev.googlecode.com/files/${P}.tar.bz2
	http://naev.googlecode.com/files/ndata-${PV}"
#	http://naev.googlecode.com/svn/trunk/site/${PN}-logo-small.png"

LICENSE="GPL-2 GPL-3 public-domain CCPL-Attribution-3.0 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug +mixer +openal"

RDEPEND="media-libs/libsdl[X,audio,video]
	dev-libs/libxml2
	>=media-libs/freetype-2
	>=media-libs/libvorbis-1.2.1
	>=media-libs/libpng-1.2.40
	media-libs/sdl-image[png]
	virtual/glu
	virtual/opengl
	mixer? ( media-libs/sdl-mixer )
	openal? ( media-libs/openal )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${P}.tar.bz2
}

src_configure() {
	egamesconf \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_with openal) \
		$(use_with mixer sdlmixer)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS conf.example README TODO

	insinto "${GAMES_DATADIR}"/${PN}
	newins "${DISTDIR}"/ndata-${PV} ndata || die

#	newicon "${DISTDIR}"/${PN}-logo-small.png ${PN}.png
	make_desktop_entry ${PN} "NAEV - Sea of Darkness"

	prepgamesdirs
}
