# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.3.6.ebuild,v 1.1 2005/01/25 13:55:04 dholm Exp $

inherit games

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.com/"
SRC_URI="mirror://sourceforge/openttd/${P}.tar.gz
	http://www.scherer.de/ottd/openttd-0.3.6.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug png zlib timidity alsa dedicated"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	!dedicated? (
		timidity? ( media-sound/timidity++ )
		!timidity? ( alsa? ( media-sound/pmidi ) )
		png? ( media-libs/libpng )
		zlib? ( sys-libs/zlib )
		media-libs/libsdl )"

src_compile() {
	local myopts="MANUAL_CONFIG=1 UNIX=1 WITH_NETWORK=1 INSTALL=1 RELEASE=${PV} USE_HOMEDIR=1 PERSONAL_DIR=.openttd PREFIX=/usr DATA_DIR=share/games/${PN}"
	use debug && myopts="${myopts} DEBUG=1"
	use dedicated && myopts="${myopts} DEDICATED=1"
	if ! use dedicated; then
		use png && myopts="${myopts} WITH_PNG=1"
		use zlib && myopts="${myopts} WITH_ZLIB=1"
		myopts="${myopts} WITH_SDL=1"
		if ! use timidity; then
			use alsa && myopts="${myopts} MIDI=/usr/bin/pmidi"
		fi
	fi

	emake -j1 ${myopts} || die "emake failed"
}

src_install() {
	dogamesbin openttd || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}/data"
	doins data/* || die "doins failed"

	insinto "${GAMES_DATADIR}/${PN}/lang"
	doins lang/*.lng || die "doins failed"

	insinto /usr/share/pixmaps
	newins media/openttd.128.png openttd.png || die "doins failed"

	if ! use dedicated; then
		make_desktop_entry openttd "OpenTTD" openttd.png
	else
		exeinto /etc/init.d
		newexe ${FILESDIR}/openttd.initd openttd
	fi

	dodoc readme.txt changelog.txt docs/Manual.txt docs/console.txt \
		docs/multiplayer.txt
	doman docs/openttd.6
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	echo
	einfo "In order to play, you must copy the following 6 files from "
	einfo "a version of TTD to ${GAMES_DATADIR}/${PN}/data/."
	echo
	einfo "From the WINDOWS version you need: "
	einfo "  sample.cat trg1r.grf trgcr.grf trghr.grf trgir.grf trgtr.grf"
	einfo "OR from the DOS version you need: "
	einfo "  SAMPLE.CAT TRG1.GRF TRGC.GRF TRGH.GRF TRGI.GRF TRGT.GRF"
	echo
	einfo "File names are case sensitive so make sure they are "
	einfo "correct for whichever version you have."
	echo

	if use dedicated; then
		einfo "You have chosen the dedicated USE flag which builds a "
		einfo "version of OpenTTD to be used as a game server which "
		einfo "does not require SDL. You will not be able to play the "
		einfo "game, but if you don't pass this flag you can still use "
		einfo "it as a server in the same way, but SDL will be required."
		echo
		ewarn "Warning: The init script will kill all running openttd"
		ewarn "processes when run, including any running client sessions!"
	else
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
	fi
		echo
}
