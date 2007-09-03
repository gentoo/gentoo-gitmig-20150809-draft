# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.5.3_rc3.ebuild,v 1.2 2007/09/03 02:32:56 mr_bones_ Exp $

inherit eutils games

MY_P=${P/_rc/-RC}

SCENARIOS_048="${PN}-0.4.8-scenarios.tar.bz2"
SCENARIOS_050="${PN}-0.5.0-scenarios.tar.bz2"

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.com/"
SB="mirror://sourceforge/openttd"
SRC_URI="${SB}/${MY_P}-source.tar.bz2
		scenarios? ( ${SB}/${SCENARIOS_048}
			${SB}/${SCENARIOS_050} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug dedicated iconv png scenarios static timidity zlib"

DEPEND="!dedicated? ( media-libs/libsdl
		media-libs/fontconfig
	)
	iconv? ( virtual/libiconv )
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	!dedicated? (
		timidity? ( media-sound/timidity++ )
		!timidity? ( alsa? ( media-sound/alsa-utils ) )
	)"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! use dedicated && ! built_with_use media-libs/libsdl X ; then
		die "Please emerge media-libs/libsdl with USE=X"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${MY_P}-source.tar.bz2
	if use scenarios ; then
		cd ${S}/scenario/
		unpack ${SCENARIOS_048}
		unpack ${SCENARIOS_050}
	fi
	cd ${S}
	# Don't pre-strip binaries (bug #137822)
	sed -i -e '/+= -s$/s/-s//' Makefile || die "sed failed"
	# Don't install into prefixed DATA_DIR
	sed -i -e \
		's#DATA_DIR_PREFIXED:=$(PREFIX)/$(DATA_DIR)#DATA_DIR_PREFIXED:=$(DATA_DIR)#' \
		Makefile || die "sed failed"
}

src_compile() {
	local myopts=""
	use debug && myopts="${myopts} --debug"
	use static && myopts="${myopts} --with-static"
	use dedicated && myopts="${myopts} --dedicated --without-sdl"
	use iconv && myopts="${myopts} --with-iconv"
	use png && myopts="${myopts} --with-png"
	use zlib && myopts="${myopts} --with-zlib"
	if ! use dedicated; then
		myopts="${myopts} --with-sdl --with-freetype --with-fontconfig"
		if ! use timidity; then
			#use alsa && myopts="${myopts} --with-midi=/usr/bin/aplaymidi"
			einfo "This RC of openttd does not support setting the midi-player."
		fi
	fi
	./configure --os=UNIX \
		--with-network \
		${myopts} \
		|| die "configure failed"

	emake \
		MANUAL_CONFIG=1 \
		INSTALL=1 \
		USE_HOMEDIR=1 \
		DEST_DIR=${D} \
		PERSONAL_DIR=.openttd \
		PREFIX=${GAMES_PREFIX} \
		DATA_DIR=${GAMES_DATADIR}/${PN} \
		CUSTOM_LANG_DIR=${GAMES_DATADIR}/${PN}/lang \
		|| die "emake failed"
}

src_install() {
	dogamesbin openttd || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}/data"
	doins data/* || die "doins failed (data)"

	insinto "${GAMES_DATADIR}/${PN}/lang"
	doins lang/*.lng || die "doins failed (lang)"

	if use scenarios ; then
		insinto "${GAMES_DATADIR}/${PN}/scenario"
		doins scenario/*.scn || die "doins failed (scenario)"
		doins scenario/*/*.scn || die "doins failed (scenario)"
	fi

	insinto "${GAMES_DATADIR}/${PN}/scripts"
	doins scripts/*.example || die "doins failed (scripts)"

	for i in {16,32,48,64,128}; do
		insinto /usr/share/icons/hicolor/${i}x${i}/apps
		newins media/openttd.${i}.png openttd.png
	done

	if ! use dedicated ; then
		if use timidity || use alsa ; then
			make_desktop_entry "openttd -m extmidi" "OpenTTD" openttd
		else
			make_desktop_entry openttd "OpenTTD" openttd
		fi
	else
		newinitd "${FILESDIR}"/openttd.initd openttd
	fi

	dodoc readme.txt known-bugs.txt changelog.txt docs/Manual.txt \
		docs/multiplayer.txt
	dohtml -a html,gif,png,svg docs/*
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

	if ! use scenarios ; then
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

	if use dedicated ; then
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
		if use timidity || use alsa ; then
			einfo "If you want music, you must copy the gm/ directory"
			einfo "to ${GAMES_DATADIR}/${PN}/"
			einfo "You can enable MIDI by running:"
			einfo "  openttd -m extmidi"
			echo
			if use timidity ; then
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
