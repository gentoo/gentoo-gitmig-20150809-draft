# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smclone/smclone-0.99.4.ebuild,v 1.1 2007/01/04 17:34:06 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils games

MUSIC_V=3.1
DESCRIPTION="Secret Maryo Chronicles"
HOMEPAGE="http://www.secretmaryo.org/"
SRC_URI="mirror://sourceforge/${PN}/SMC_${PV}_game.zip
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
	epatch "${FILESDIR}"/${P}-leveldir.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/icon/window_32.png ${PN}.png
	make_desktop_entry smc "Secret Maryo Chronicles"
	dodoc docs/*.txt
	dohtml docs/{*.css,*.html}
	prepgamesdirs
}
