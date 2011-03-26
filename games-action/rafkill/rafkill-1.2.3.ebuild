# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/rafkill/rafkill-1.2.3.ebuild,v 1.7 2011/03/26 17:20:09 ssuominen Exp $

EAPI=2
inherit eutils scons-utils games

DESCRIPTION="space shoot-em-up game"
HOMEPAGE="http://raptorv2.sourceforge.net/"
SRC_URI="mirror://sourceforge/raptorv2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE=""

DEPEND="<media-libs/allegro-5
	media-libs/aldumb"

src_prepare() {
	rm -f {data,music}/.sconsign
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e "/^#define INSTALL_DIR/s:\.:${GAMES_DATADIR}:" \
		src/defs.cpp \
		|| die "sed failed"
}

src_compile() {
	escons || die
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data music || die "doins failed"
	dodoc README
	prepgamesdirs
}
