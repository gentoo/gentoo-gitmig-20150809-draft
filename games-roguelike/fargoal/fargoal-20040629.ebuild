# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/fargoal/fargoal-20040629.ebuild,v 1.4 2011/03/26 17:26:08 ssuominen Exp $

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

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}/src"
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
}

src_compile() {
	emake -C src || die "emake failed"
}

src_install() {
	# install as fargoal instead of sword since that may conflict with
	# other packages.
	newgamesbin sword fargoal || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r agreement.txt {data,gfx,sfx} || die "doins failed"
	dohtml readme.html
	prepgamesdirs
}
