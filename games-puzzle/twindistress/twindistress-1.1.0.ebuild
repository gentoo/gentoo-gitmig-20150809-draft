# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/twindistress/twindistress-1.1.0.ebuild,v 1.1 2006/09/30 00:34:01 nyhm Exp $

inherit eutils toolchain-funcs games

MY_P="twind-${PV}"
DESCRIPTION="Match and remove all of the blocks before time runs out"
HOMEPAGE="http://twind.sourceforge.net/"
SRC_URI="mirror://sourceforge/twind/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CC/s:gcc:$(tc-getCC):" \
		-e "/^CFLAGS/s:-g:${CFLAGS}:" \
		-e "/^DATA_PREFIX/s:/.*$:${GAMES_DATADIR}/${PN}/:" \
		-e "/^HIGH_SCORE_PREFIX/s:/.*$:${GAMES_STATEDIR}/${PN}/:" \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin twind || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r graphics music sound || die "doins failed"

	doicon graphics/twind.png
	make_desktop_entry twind "Twin Distress" twind.png

	dodoc AUTHORS ChangeLog CREDITS NEWS README TODO

	dodir "${GAMES_STATEDIR}/${PN}"
	touch "${D}/${GAMES_STATEDIR}/${PN}/twind.hscr"
	fperms 660 "${GAMES_STATEDIR}/${PN}/twind.hscr"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! built_with_use media-libs/sdl-mixer vorbis ; then
		ewarn "Music support will be disabled since sdl-mixer"
		ewarn "wasn't built with USE=vorbis"
	fi
}
