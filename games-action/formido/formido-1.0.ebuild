# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/formido/formido-1.0.ebuild,v 1.3 2004/11/02 20:57:01 josejx Exp $

inherit eutils games

DESCRIPTION="A shooting game in the spirit of Phobia games"
HOMEPAGE="http://www.mhgames.cjb.net/"
SRC_URI="http://koti.mbnet.fi/lsoft/formido/${P}.tar.bz2
	http://koti.mbnet.fi/lsoft/formido/formido-music.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT=0
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${P}.tar.bz2

	cd ${S}
	epatch "${FILESDIR}/homedir.patch"

	sed -i \
		-e "/^FLAGS/ s:$: ${CXXFLAGS}:" Makefile || \
			die "sed Makefile failed"

	cd ${S}/data
	unpack ${PN}-music.tar.bz2
}

src_compile() {
	emake \
		CONFIGDIR="${GAMES_DATADIR}/${PN}" \
		DATDIR="${GAMES_DATADIR}/${PN}/data" \
		HISCOREDIR="${GAMES_STATEDIR}/${PN}" || die "emake failed"
}

src_install() {
	dogamesbin formido     || die "dogamesbin failed"
	dodoc README           || die "dodoc failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins "${PN}.cfg"      || die "doins failed (cfg)"

	insinto "${GAMES_DATADIR}/${PN}/data"
	doins data/*           || die "doins failed (data)"
	# no need to install this twice.
	rm -f "${D}${GAMES_DATADIR}/${PN}/data/hiscore.dat"

	insinto "${GAMES_STATEDIR}/${PN}"
	insopts -m 664
	doins data/hiscore.dat || die "doins failed (hiscore)"

	prepgamesdirs
}
