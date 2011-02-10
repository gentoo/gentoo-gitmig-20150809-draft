# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xpilot-ng/xpilot-ng-4.7.3.ebuild,v 1.2 2011/02/10 11:22:05 phajdan.jr Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit python eutils multilib games

DESCRIPTION="Improvement of the multiplayer space game XPilot"
HOMEPAGE="http://xpilot.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpilot/xpilot_ng/${P}/${P}.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
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

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}"-xpngcc.patch

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
	insinto "${GAMES_DATADIR}"/${PN}/xpngcc
	doins contrib/xpngcc/*.py contrib/xpngcc/*.png
	exeinto "${GAMES_DATADIR}"/${PN}/xpngcc
	doexe contrib/xpngcc/xpngcc.py
	dodir $(python_get_sitedir)
	dosym "${GAMES_DATADIR}"/${PN}/xpngcc $(python_get_sitedir)/xpngcc
	dosym "${GAMES_DATADIR}"/${PN}/xpngcc/xpngcc.py "${GAMES_BINDIR}"/xpilot-ng
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} "XPilot NG"
	prepgamesdirs
}
