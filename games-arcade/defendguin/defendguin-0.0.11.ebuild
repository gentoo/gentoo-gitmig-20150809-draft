# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/defendguin/defendguin-0.0.11.ebuild,v 1.7 2009/01/09 19:38:12 mr_bones_ Exp $

EAPI=2
inherit eutils toolchain-funcs games

DESCRIPTION="A clone of the arcade game Defender, but with a Linux theme"
HOMEPAGE="http://www.newbreedsoftware.com/defendguin/"
SRC_URI="ftp://ftp.billsgames.com/unix/x/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/sdl-mixer[mikmod]
	media-libs/libsdl"

src_prepare() {
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
