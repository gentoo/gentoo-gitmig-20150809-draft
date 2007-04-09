# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/defendguin/defendguin-0.0.11.ebuild,v 1.6 2007/04/09 21:57:46 welp Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="A clone of the arcade game Defender, but with a Linux theme"
HOMEPAGE="http://www.newbreedsoftware.com/defendguin/"
SRC_URI="ftp://ftp.billsgames.com/unix/x/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/libsdl"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod; then
		die "Please build media-libs/sdl-mixer with USE=mikmod"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "1i CC=$(tc-getCC)" \
		-e "s:\$(DATA_PREFIX):${GAMES_DATADIR}/${PN}/:" \
		-e "s:-Wall:-Wall ${CFLAGS}:" \
		Makefile \
		|| die "sed failed"
	rm -f data/images/*.sh
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ./data/* || die "doins failed"
	newicon data/images/ufo/ufo0.bmp ${PN}.bmp
	make_desktop_entry ${PN} Defendguin /usr/share/pixmaps/${PN}.bmp
	doman src/${PN}.6
	dodoc docs/{AUTHORS,CHANGES,README,TODO}.txt
	prepgamesdirs
}
