# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.6.3.ebuild,v 1.5 2009/02/01 21:07:22 dertobi123 Exp $

EAPI="2"

inherit eutils games

MY_P=${P/_rc/-RC}

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.org/"
SRC_URI="http://binaries.openttd.org/releases/${PV}/${MY_P}-source.tar.bz2"
SCENARIOS="0.4.8 0.5.0"
for scenario in ${SCENARIOS}; do
	SRC_URI="${SRC_URI} scenarios? (
	http://binaries.openttd.org/scenarios/${PN}-${scenario}-scenarios.tar.bz2 )"
done

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="alsa debug dedicated iconv +png scenarios timidity +truetype +zlib"
RESTRICT="test"

DEPEND="!dedicated? (
			media-libs/libsdl[X]
			truetype? (
				media-libs/fontconfig
				media-libs/freetype:2
			)
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

src_unpack() {
	unpack ${MY_P}-source.tar.bz2

	if use scenarios ; then
		cd "${S}"/bin/scenario/
		for scenario in ${SCENARIOS}; do
			unpack ${PN}-${scenario}-scenarios.tar.bz2
		done
	fi

	cd "${S}"
	epatch "${FILESDIR}/libiconv.patch"
	epatch "${FILESDIR}/install.patch"
	epatch "${FILESDIR}/menu_name.patch"
}

src_configure() {
	local myopts=""
	use debug && myopts="${myopts} --enable-debug=3"
	if use dedicated; then
		myopts="${myopts} --enable-dedicated "
	else
		myopts="${myopts} --with-sdl $(use_with truetype freetype)
			$(use_with truetype fontconfig)"
		if ! use timidity; then
			use alsa && myopts="${myopts} --with-midi=/usr/bin/aplaymidi"
		fi
	fi
	# configure is a hand-written sh-script, so econf will not work
	./configure --disable-strip \
		--prefix-dir=/usr \
		--binary-dir=games/bin \
		--data-dir=share/games/${PN} \
		--install-dir="${D}" \
		--doc-dir=share/doc/${P} \
		--menu-group="Game;Simulation;" \
		$(use_with iconv) \
		$(use_with png) \
		$(use_with zlib) \
		${myopts} \
		|| die "configure failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use scenarios ; then
		insinto "${GAMES_DATADIR}"/${PN}/scenario
		doins bin/scenario/*.scn || die "doins failed (scenario)"
		doins bin/scenario/*/*.scn || die "doins failed (scenario)"
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog
	elog "In order to play, you must copy the following 6 files from "
	elog "a version of TTD to ${GAMES_DATADIR}/${PN}/data/."
	elog
	elog "From the WINDOWS version you need: "
	elog "  sample.cat trg1r.grf trgcr.grf trghr.grf trgir.grf trgtr.grf"
	elog "OR from the DOS version you need: "
	elog "  SAMPLE.CAT TRG1.GRF TRGC.GRF TRGH.GRF TRGI.GRF TRGT.GRF"
	elog
	elog "File names are case sensitive so make sure they are "
	elog "correct for whichever version you have."
	elog

	if use scenarios ; then
		elog "Scenarios are installed into:"
		elog "${GAMES_DATADIR}/${PN}/scenario,"
		elog "you will have to symlink them to ~/.openttd/scenario in order"
		elog "to use them."
		elog "Example:"
		elog " ln -s ${GAMES_DATADIR}/${PN}/scenario ~/.openttd/scenario"
		elog
	fi

	if use dedicated ; then
		ewarn "Warning: The init script will kill all running openttd"
		ewarn "processes when run, including any running client sessions!"
	else
		if use timidity || use alsa ; then
			elog "If you want music, you must copy the gm/ directory to"
			elog "${GAMES_DATADIR}/${PN}/"
			elog "You can enable MIDI by running:"
			elog "  openttd -m extmidi"
			elog
			if use timidity ; then
				elog "You also need soundfonts for timidity, if you don't"
				elog "know what that is, do:"
				elog
				elog "emerge media-sound/timidity-eawpatches"
			else
				elog "You have emerged with 'aplaymidi' for playing MIDI."
				elog "You have to set the environment variable ALSA_OUTPUT_PORTS."
				elog "Available ports can be listed by using 'aplaymidi -l'."
			fi
		else
			elog "timidity and/or alsa not in USE so music will not be played during the game."
		fi
		elog
	fi
}
