# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/jag/jag-0.3.0.ebuild,v 1.3 2010/02/23 11:28:04 fauli Exp $

EAPI=2
inherit eutils qt4 games

DESCRIPTION="Arcade 2D Puzzle Game"
HOMEPAGE="http://jag.xlabsoft.com/"
SRC_URI="http://jag.xlabsoft.com/files/${P}-src.zip
	http://jag.xlabsoft.com/files/jag_levels_sunzero.zip
	extras? ( http://jag.xlabsoft.com/files/jag_seven_themes.zip )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="editor extras"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/libXrandr
	media-libs/libsdl[audio,video]
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${P}-src

src_prepare() {
	sed -i \
		-e "s:/usr/local/bin:${GAMES_BINDIR}:g" \
		-e "s:/usr/local/games:${GAMES_DATADIR}:g" \
		-e "s:LIBS += -lSDLmain:LIBS += -lSDL:" \
		Game.pro main.cpp editor/editor.pro \
		|| die "sed failed"
}

src_configure() {
	eqmake4 Game.pro
	if use editor; then
		cd editor
		eqmake4 editor.pro
	fi
}

src_compile() {
	emake || die
	if use editor; then
		emake -C editor || die
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	newicon images/logo.png ${PN}.png
	make_desktop_entry jag Jag

	if use editor; then
		emake -C editor INSTALL_ROOT="${D}" install || die
		make_desktop_entry jag-editor "Jag Level editor" ${PN}
	fi

	insinto "${GAMES_DATADIR}/${PN}"/data/levels
	doins -r "${WORKDIR}"/sunzero.lpk || die "doins failed"

	if use extras; then
		insinto "${GAMES_DATADIR}/${PN}"/data/schemes
		doins -r "${WORKDIR}"/{african,animals,chinese,creatures,futurama,kde-nuvola,toys} || die "doins failed"
	fi
	prepgamesdirs
}
