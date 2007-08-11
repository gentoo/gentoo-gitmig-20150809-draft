# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smclone/smclone-1.0.ebuild,v 1.2 2007/08/11 13:29:35 nyhm Exp $

inherit eutils games

DESCRIPTION="Secret Maryo Chronicles"
HOMEPAGE="http://www.secretmaryo.org/"
SRC_URI="mirror://sourceforge/${PN}/smc-${PV}.tar.bz2
	mirror://sourceforge/${PN}/SMC_music_4.0_high.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-games/cegui-0.5.0
	dev-libs/boost
	virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}/smc-${PV}

pkg_setup() {
	games_pkg_setup
	if ! built_with_use media-libs/sdl-image png ; then
		die "Please emerge sdl-image with USE=png"
	fi
	if ! built_with_use dev-games/cegui opengl ; then
		die "Please emerge cegui with USE=opengl"
	fi
	if ! built_with_use dev-games/cegui devil ; then
		die "Please emerge cegui with USE=devil"
	fi
}

src_unpack() {
	unpack smc-${PV}.tar.bz2
	cd "${S}"
	unpack SMC_music_4.0_high.zip
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/icon/window_32.png ${PN}.png
	make_desktop_entry smc "Secret Maryo Chronicles"
	dodoc docs/*.txt
	dohtml docs/{*.css,*.html}
	prepgamesdirs
}
