# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ppracer/ppracer-0.3.1.ebuild,v 1.13 2006/10/19 00:04:14 nyhm Exp $

inherit eutils flag-o-matic multilib games

DESCRIPTION="take on the role of Tux, the Linux Penguin, as he races down steep, snow-covered mountains"
HOMEPAGE="http://developer.berlios.de/projects/ppracer/"
SRC_URI="http://download.berlios.de/ppracer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXext
	>=dev-lang/tcl-8.4
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/libpng
	>=media-libs/freetype-2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/ppracer-0.3.1-gcc41.patch
}

src_compile() {
	# alpha needs -mieee for this game to avoid FPE
	use alpha && append-flags -mieee

	egamesconf \
		--disable-dependency-tracking \
		--with-data-dir="${GAMES_DATADIR}/${PN}" \
		--with-tcl=/usr/$(get_libdir) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	newicon data/courses/themes/items/common/herring_standard.png ${PN}.png
	make_desktop_entry ${PN} "PlanetPenguin Racer"
	dodoc AUTHORS ChangeLog
	dohtml -r html/*
	prepgamesdirs
}
