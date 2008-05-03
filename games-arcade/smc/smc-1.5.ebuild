# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smc/smc-1.5.ebuild,v 1.1 2008/05/03 02:11:37 nyhm Exp $

inherit eutils games

MUSIC_P=SMC_music_4.0_high
DESCRIPTION="Secret Maryo Chronicles"
HOMEPAGE="http://www.secretmaryo.org/"
SRC_URI="mirror://sourceforge/smclone/${P}.tar.bz2
	mirror://sourceforge/smclone/${MUSIC_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-games/cegui
	dev-libs/boost
	virtual/opengl
	virtual/glu
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

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
	if ! built_with_use dev-libs/libpcre unicode ; then
		die "Please emerge dev-libs/libpcre with USE=unicode"
	fi
}

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	unpack ${MUSIC_P}.zip
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/icon/window_32.png smc.png
	make_desktop_entry ${PN} "Secret Maryo Chronicles"
	doman makefiles/unix/man/smc.6
	dodoc docs/*.txt
	dohtml docs/{*.css,*.html}
	prepgamesdirs
}
