# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chickens/chickens-0.2.4.ebuild,v 1.1 2004/07/21 08:00:42 mr_bones_ Exp $

inherit games

MY_P="ChickensForLinux-Linux-${PV}"
DESCRIPTION="Target chickens with rockets and shotguns. Funny"
HOMEPAGE="http://havoc.sourceforge.net/chickens"
SRC_URI="http://havoc.sourceforge.net/chickens/files/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/x11
	media-libs/allegro"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/chickens"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:HighScores:${GAMES_STATEDIR}/${PN}/HighScores:" \
		-e "s:....\(.\)\(_\)\(.*.4x0\)\(.\):M\4\2\x42\x6Fn\1s\2:" \
		highscore.cpp HighScores \
		|| die "sed highscore.cpp failed"
	sed -i \
		-e "s:options.cfg:${GAMES_SYSCONFDIR}/${PN}/options.cfg:" \
		-e "s:\"sound/:\"${GAMES_DATADIR}/${PN}/sound/:" \
		-e "s:\"dat/:\"${GAMES_DATADIR}/${PN}/dat/:" main.cpp README \
		|| die "sed main.cpp failed"
	chmod a-x {dat,sound}/*
}

src_install() {
	dogamesbin chickens || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r {dat,sound} "${D}/${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"
	dodoc AUTHOR README
	insinto "${GAMES_STATEDIR}/${PN}"
	doins HighScores || die "doins failed"
	insinto "${GAMES_SYSCONFDIR}/${PN}"
	doins options.cfg || die "doins failed"
	fperms g+w "${GAMES_STATEDIR}/${PN}/HighScores"
	prepgamesdirs

}
