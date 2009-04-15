# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smc/smc-1.7.ebuild,v 1.6 2009/04/15 20:08:08 gentoofan23 Exp $

EAPI=2
inherit eutils games

MUSIC_P=SMC_Music_4.1_high
DESCRIPTION="Secret Maryo Chronicles"
HOMEPAGE="http://www.secretmaryo.org/"
SRC_URI="mirror://sourceforge/smclone/${P}.tar.bz2
	mirror://sourceforge/smclone/${MUSIC_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-games/cegui[opengl,devil]
	dev-libs/boost
	virtual/opengl
	virtual/glu
	dev-libs/libpcre[unicode]
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

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
