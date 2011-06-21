# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/fargoal/fargoal-20040629.ebuild,v 1.5 2011/06/21 14:46:50 tupone Exp $
EAPI=2

inherit eutils games

DESCRIPTION="The Sword of Fargoal - a remake of C64's old dungeon crawler game"
HOMEPAGE="http://squidfighter.sourceforge.net/fargoal/"
SRC_URI="mirror://sourceforge/squidfighter/${P/-}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="<media-libs/allegro-5"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${PN}/src

src_prepare() {
	epatch "${FILESDIR}/gentoo-home-write.patch"
	sed -i \
		-e "s/-O3/${CFLAGS}/" \
		-e '/^LDFLAGS/d' Makefile \
		|| die "sed failed"
	sed -i \
		-e "s:sfx/:${GAMES_DATADIR}/${PN}/sfx/:g" \
		-e "s:gfx/:${GAMES_DATADIR}/${PN}/gfx/:g" \
		-e "s:data/:${GAMES_DATADIR}/${PN}/data/:g" {*,../data/sof.cfg} \
		|| die "sed failed"
	sed -i \
		-e "s:agreement.txt:${GAMES_DATADIR}/${PN}/&:" main.c \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-underlink.patch
}

src_install() {
	cd ..
	# install as fargoal instead of sword since that may conflict with
	# other packages.
	newgamesbin sword fargoal || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r agreement.txt {data,gfx,sfx} || die "doins failed"
	dohtml readme.html
	prepgamesdirs
}
