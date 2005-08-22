# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.4.0.1.ebuild,v 1.2 2005/08/22 20:27:05 hansmi Exp $

inherit eutils games

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.com/"
SRC_URI="mirror://sourceforge/openttd/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="debug png zlib timidity alsa dedicated"

DEPEND="media-libs/libsdl
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	!dedicated? (
		timidity? ( media-sound/timidity++ )
		!timidity? ( alsa? ( media-sound/alsa-utils ) )
	)"

src_compile() {
	local myopts="MANUAL_CONFIG=1 UNIX=1 WITH_NETWORK=1 INSTALL=1 RELEASE=${PV} USE_HOMEDIR=1 PERSONAL_DIR=.openttd PREFIX=/usr DATA_DIR=share/games/${PN}"
	use debug && myopts="${myopts} DEBUG=1"
	use dedicated && myopts="${myopts} DEDICATED=1"
	use png && myopts="${myopts} WITH_PNG=1"
	use zlib && myopts="${myopts} WITH_ZLIB=1"
	if ! use dedicated; then
		myopts="${myopts} WITH_SDL=1"
		if ! use timidity; then
			use alsa && myopts="${myopts} MIDI=/usr/bin/aplaymidi"
		fi
	fi

	emake -j1 ${myopts} || die "emake failed"
}

src_install() {
	dogamesbin openttd || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}/data"
	doins data/* || die "doins failed (data)"

	insinto "${GAMES_DATADIR}/${PN}/lang"
	doins lang/*.lng || die "doins failed (lang)"

	insinto "${GAMES_DATADIR}/${PN}/scenario"
	doins scenario/* || die "doins failed (scenario)"

	insinto "${GAMES_DATADIR}/${PN}/scripts"
	doins scripts/*.example || die "doins failed (scripts)"

	doicon media/openttd.*.png

	if ! use dedicated; then
		if use timidity || use alsa; then
			make_desktop_entry "openttd -m extmidi" "OpenTTD" openttd.64.png
		else
			make_desktop_entry openttd "OpenTTD" openttd.64.png
		fi
	else
		exeinto /etc/init.d
		newexe ${FILESDIR}/openttd.initd openttd
	fi

	dodoc readme.txt changelog.txt docs/Manual.txt docs/console.txt \
		docs/multiplayer.txt
	newdoc scripts/readme.txt readme_scripts.txt
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
	einfo "Scenarios are installed to ${GAMES_DATADIR}/${PN}/scenario,"
	einfo "you will have to symlink them to ~/.openttd/scenario in order"
	einfo "to use them."
	einfo "Example:"
	einfo "  mkdir -p ~/.openttd/scenario"
	einfo "  ln -s ${GAMES_DATADIR}/${PN}/scenario/* ~/.openttd/scenario/"
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
		echo
	else
		if use timidity || use alsa; then
			einfo "If you want music, you must copy the gm/ directory"
			einfo "to ${GAMES_DATADIR}/${PN}/"
			einfo "You can enable MIDI by running:"
			einfo "  openttd -m extmidi"
			echo
			if use timidity; then
				einfo "You also need soundfonts for timidity, if you don't"
				einfo "know what that is, do:"
				echo
				einfo "emerge media-sound/timidity-eawpatches"
			else
				einfo "You have emerged with 'aplaymidi' for playing MIDI."
				einfo "You have to set the environment variable ALSA_OUTPUT_PORTS."
				einfo "Available ports can be listed by using 'aplaymidi -l'."
			fi
		else
			einfo "timidity and/or alsa not in USE so music will not be played during the game."
		fi
		echo
	fi
}
