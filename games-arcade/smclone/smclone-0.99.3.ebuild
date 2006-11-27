# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smclone/smclone-0.99.3.ebuild,v 1.3 2006/11/27 23:42:09 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils games

MUSIC_V=3.1
DESCRIPTION="Secret Maryo Chronicles"
HOMEPAGE="http://www.secretmaryo.org/"
SRC_URI="mirror://sourceforge/${PN}/SMC_${PV}_source.zip
	mirror://sourceforge/${PN}/SMC_${PV}_game.zip
	mirror://sourceforge/${PN}/music_${MUSIC_V}_high.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-games/cegui-0.5.0
	virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	if ! built_with_use media-libs/sdl-image png ; then
		die "Please emerge sdl-image with USE=png"
	fi
	if ! built_with_use dev-games/cegui devil opengl ; then
		die "Please emerge cegui with USE=\"devil opengl\""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f configure data/Makefile* docs/license.txt
	sed -i "s:data/:${GAMES_DATADIR}/${PN}/:" \
		$(find data/gui -type f) \
		|| die "sed failed"
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-paths.patch
	eautoreconf
}

src_install() {
	newgamesbin src/smc ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"
	insinto "${GAMES_DATADIR}"/${PN}/gui/font
	doins Font.xsd || die "doins Font.xsd failed"
	insinto "${GAMES_DATADIR}"/${PN}/gui/imagesets
	doins Imageset.xsd || die "doins Imageset.xsd failed"
	insinto "${GAMES_DATADIR}"/${PN}/gui/layout
	doins GUILayout.xsd || die "doins GUILayout.xsd failed"
	insinto "${GAMES_DATADIR}"/${PN}/gui/looknfeel
	doins Falagard.xsd || die "doins Falagard.xsd failed"
	insinto "${GAMES_DATADIR}"/${PN}/gui/schemes
	doins GUIScheme.xsd || die "doins GUIScheme.xsd failed"
	newicon data/icon/window_32.png ${PN}.png
	make_desktop_entry ${PN} "Secret Maryo Chronicles"
	dodoc docs/*.txt
	dohtml docs/{*.css,*.html}
	prepgamesdirs
}
