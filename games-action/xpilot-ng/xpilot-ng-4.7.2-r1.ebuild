# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xpilot-ng/xpilot-ng-4.7.2-r1.ebuild,v 1.8 2009/11/23 13:46:30 maekke Exp $

EAPI=2
inherit python eutils multilib games

DESCRIPTION="Improvement of the multiplayer space game XPilot"
HOMEPAGE="http://xpilot.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpilot/${P}.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="openal sdl"

RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	dev-libs/expat
	openal? ( media-libs/openal )
	dev-python/wxpython:2.6
	sdl? (
		virtual/opengl
		media-libs/libsdl
		media-libs/sdl-image
		media-libs/sdl-ttf
	)"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_prepare() {
	epatch "${FILESDIR}/${P}"-xpngcc.patch \
		"${FILESDIR}"/${P}-glibc210.patch

	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		contrib/xpngcc/config.py \
		|| die "sed failed"
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable sdl sdl-client) \
		$(use_enable sdl sdl-gameloop) \
		$(use_enable openal sound)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	python_version
	insinto "${GAMES_DATADIR}"/${PN}/xpngcc
	doins contrib/xpngcc/*.py contrib/xpngcc/*.png
	exeinto "${GAMES_DATADIR}"/${PN}/xpngcc
	doexe contrib/xpngcc/xpngcc.py
	dodir /usr/$(get_libdir)/python${PYVER}/site-packages
	dosym "${GAMES_DATADIR}"/${PN}/xpngcc /usr/$(get_libdir)/python${PYVER}/site-packages/xpngcc
	dosym "${GAMES_DATADIR}"/${PN}/xpngcc/xpngcc.py "${GAMES_BINDIR}"/xpilot-ng
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} "XPilot NG"
	prepgamesdirs
}
