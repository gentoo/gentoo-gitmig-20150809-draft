# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.4.8.ebuild,v 1.7 2007/01/06 16:05:00 pylon Exp $

inherit eutils games

SCENARIOS_A="${P}-scenarios.tar.bz2"
SCENARIOS_DIR="${P}-RC1-scenarios"

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.com/"
SB="mirror://sourceforge/openttd"
SRC_URI="${SB}/${P}-source.tar.bz2
		scenarios? ( ${SB}/${SCENARIOS_A} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug png zlib timidity alsa dedicated scenarios"

DEPEND="!dedicated? ( media-libs/libsdl )
	png? ( media-libs/libpng )
	scenarios? ( app-arch/unzip )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	!dedicated? (
		timidity? ( media-sound/timidity++ )
		!timidity? ( alsa? ( media-sound/alsa-utils ) )
	)"

src_unpack() {
	unpack ${P}-source.tar.bz2
	if use scenarios; then
		cd ${S}/scenario/
		unpack ${SCENARIOS_A}
	fi
	cd ${S}
	# Don't pre-strip binaries (bug #137822)
	sed -i -e '/+= -s$/s/-s//' Makefile || die "sed failed"
	# Don't install into prefixed DATA_DIR
	sed -i -e 's#DATA_DIR_PREFIXED:=$(PREFIX)/$(DATA_DIR)#DATA_DIR_PREFIXED:=$(DATA_DIR)#' Makefile || die "sed failed"
}

src_compile() {
	local myopts=""
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

	# parallel build not supported
	emake -j1 \
		MANUAL_CONFIG=1 \
		UNIX=1 \
		WITH_NETWORK=1 \
		INSTALL=1 \
		RELEASE=${PV} \
		USE_HOMEDIR=1 \
		DEST_DIR=${D} \
		PERSONAL_DIR=.openttd \
		PREFIX=${GAMES_PREFIX} \
		DATA_DIR=${GAMES_DATADIR}/${PN} \
		CUSTOM_LANG_DIR=${GAMES_DATADIR}/${PN}/lang \
		${myopts} \
		|| die "emake failed"
}

src_install() {
	dogamesbin openttd || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}/data"
	doins data/* || die "doins failed (data)"

	insinto "${GAMES_DATADIR}/${PN}/lang"
	doins lang/*.lng || die "doins failed (lang)"

	if use scenarios; then
		insinto "${GAMES_DATADIR}/${PN}/scenario"
		doins scenario/${SCENARIOS_DIR}/* || die "doins failed (scenario)"
	fi

	insinto "${GAMES_DATADIR}/${PN}/scripts"
	doins scripts/*.example || die "doins failed (scripts)"

	for i in {16,32,48,64,128}; do
		insinto /usr/share/icons/hicolor/${i}x${i}/apps
		newins media/openttd.${i}.png openttd.png
	done

	if ! use dedicated; then
		if use timidity || use alsa; then
			make_desktop_entry "openttd -m extmidi" "OpenTTD" openttd
		else
			make_desktop_entry openttd "OpenTTD" openttd
		fi
	else
		newinitd "${FILESDIR}"/openttd.initd openttd
	fi

	dodoc readme.txt known-bugs.txt changelog.txt docs/Manual.txt docs/console.txt docs/multiplayer.txt
	dohtml -a html,gif,png docs/*
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
	einfo "File names are case sensitive so make sure they are "
	einfo "correct for whichever version you have."
	echo

	if ! use scenarios; then
		einfo "Scenarios are now included in a seperate package. To "
		einfo "install them as well please remerge with the "
		einfo "\"scenarios\" USE flag."
		echo
	else
		einfo "Scenarios are installed to ${GAMES_DATADIR}/${PN}/scenario,"
		einfo "you will have to symlink them to ~/.openttd/scenario in order"
		einfo "to use them."
		einfo "Example:"
		einfo "  mkdir -p ~/.openttd/scenario"
		einfo "  ln -s ${GAMES_DATADIR}/${PN}/scenario/* ~/.openttd/scenario/"
		echo
	fi

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
