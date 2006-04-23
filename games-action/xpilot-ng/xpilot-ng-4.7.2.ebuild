# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xpilot-ng/xpilot-ng-4.7.2.ebuild,v 1.2 2006/04/23 10:32:43 tupone Exp $

inherit python games

DESCRIPTION="Improvement of the multiplayer space game XPilot"
HOMEPAGE="http://xpilot.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpilot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="openal sdl"

RDEPEND="|| (
	(
		x11-libs/libX11
		x11-libs/libICE
		x11-libs/libSM )
	virtual/x11 )
	>=dev-libs/expat-1.1
	>=sys-libs/zlib-1.1.3
	openal? ( media-libs/openal )
	dev-python/wxpython
	sdl? (
		virtual/opengl
		>=media-libs/libsdl-1.2.0
		>=media-libs/sdl-image-1.0
		>=media-libs/sdl-ttf-2.0 )"
DEPEND="${RDEPEND}
	|| (
		(
			x11-proto/xextproto
			x11-proto/xproto
			x11-libs/libXt )
		virtual/x11 )"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable sdl sdl-client) \
		$(use_enable sdl sdl-gameloop) \
		$(use_enable openal sound) \
		|| die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	python_version
	insinto ${GAMES_DATADIR}/${PN}/xpngcc
	doins contrib/xpngcc/*.py contrib/xpngcc/*.png
	exeinto ${GAMES_DATADIR}/${PN}/xpngcc
	doexe contrib/xpngcc/xpngcc.py
	dodir /usr/$(get_libdir)/python${PYVER}/site-packages
	dosym ${GAMES_DATADIR}/${PN}/xpngcc /usr/$(get_libdir)/python${PYVER}/site-packages/xpngcc
	dosym ${GAMES_DATADIR}/${PN}/xpngcc/xpngcc.py ${GAMES_BINDIR}/xpilot-ng
	doicon ${FILESDIR}/${PN}.png
	make_desktop_entry ${PN} "XPilot NG" ${PN}.png
	prepgamesdirs
}
