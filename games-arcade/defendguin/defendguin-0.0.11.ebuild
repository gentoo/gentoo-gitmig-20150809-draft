# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/defendguin/defendguin-0.0.11.ebuild,v 1.3 2006/04/18 00:11:05 mr_bones_ Exp $

inherit eutils games
DESCRIPTION="A clone of the arcade game Defender, but with a Linux theme"
HOMEPAGE="http://www.newbreedsoftware.com/defendguin/"
SRC_URI="ftp://ftp.billsgames.com/unix/x/defendguin/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/libsdl"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod; then
		die "You need to build media-libs/sdl-mixer with mikmod USE flag enabled!"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-makefile.patch"
	rm -f data/images/*.sh
}

src_install() {
	dogamesbin defendguin || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ./data/* || die "doins failed"
	prepgamesdirs
}
