# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.3.4.ebuild,v 1.2 2004/09/20 04:17:23 mr_bones_ Exp $

inherit games

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.com/"
SRC_URI="mirror://sourceforge/openttd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug png zlib timidity"

DEPEND="virtual/libc
	media-libs/libsdl
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	timidity? ( media-sound/timidity++ )"

src_compile() {
	local myopts="MANUAL_CONFIG=1 UNIX=1 WITH_SDL=1 WITH_NETWORK=1 USE_HOMEDIR=1 PERSONAL_DIR=.openttd GAME_DATA_DIR=${GAMES_DATADIR}/${PN}/"
	use debug && myopts="${myopts} DEBUG=1"
	use png && myopts="${myopts} WITH_PNG=1"
	use zlib && myopts="${myopts} WITH_ZLIB=1"

	emake -j1 ${myopts} || die "emake failed"
}

src_install() {
	dogamesbin openttd || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}/data"
	doins data/* || die "doins failed"

	insinto "${GAMES_DATADIR}/${PN}/lang"
	doins lang/*.lng || die "doins failed"

	insinto /usr/share/pixmaps
	newins media/icon128.png openttd.png || die "doins failed"

	make_desktop_entry openttd "OpenTTD" openttd.png
	dodoc readme.txt changelog.txt docs/Manual.txt docs/console.txt
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	echo
	einfo "In order to play, you must copy the following 6 files from "
	einfo "the *WINDOWS* version of TTD to ${GAMES_DATADIR}/${PN}/data/"
	echo
	einfo "sample.cat trg1r.grf trgcr.grf trghr.grf trgir.grf trgtr.grf"
	echo
	if use timidity ; then
		einfo "If you want music, you must copy the gm/ directory"
		einfo "to ${GAMES_DATADIR}/${PN}/"
		echo
		einfo "You also need soundfonts for timidity, if you don't"
		einfo "know what that is, do:"
		echo
		einfo "emerge media-sound/timidity-eawpatches"
	else
		einfo "timidity not in USE so music will not be played during the game."
	fi
	echo
}
