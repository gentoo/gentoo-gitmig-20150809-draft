# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/twindistress/twindistress-1.03.ebuild,v 1.7 2006/08/15 15:11:58 tcort Exp $

inherit eutils games

MY_P="twind-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Match and remove all of the blocks before time runs out"
HOMEPAGE="http://twind.sourceforge.net/"
SRC_URI="mirror://sourceforge/twind/${MY_P}.tar.gz"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/usr/local/bin/:${GAMES_BINDIR}/:" \
		-e "s:/usr/local/share/games/twind/:${GAMES_DATADIR}/${PN}/:" \
		-e "s:/var/lib/games/twind/:${GAMES_STATEDIR}/${PN}/:" \
			Makefile \
				|| die "sed Makefile failed"
}

src_install() {
	dogamesbin twind || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r graphics/ music/ sound/ "${D}${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"
	insinto /usr/share/pixmaps
	doins graphics/twind.png || die "doins failed"
	make_desktop_entry twind "Twin Distress" twind.png \
		|| die "make_desktop_entry failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO || die "dodoc failed"
	dodir "${GAMES_STATEDIR}/${PN}" || die "dodir failed"
	touch "${D}${GAMES_STATEDIR}/${PN}/twind.hscr"
	prepgamesdirs
	fperms 660 "${GAMES_STATEDIR}/${PN}/twind.hscr" || die "fperms failed"
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "If sdl_mixer isn't built with ogg vorbis support, then you won't"
	einfo "be able to hear the music"
	echo
}
