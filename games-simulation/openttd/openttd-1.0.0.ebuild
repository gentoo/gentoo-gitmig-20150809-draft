# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-1.0.0.ebuild,v 1.1 2010/04/18 07:35:40 mr_bones_ Exp $

EAPI=2
inherit eutils games

MY_PV=${PV/_rc/-RC}
MY_P=${PN}-${MY_PV}

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.org/"
SRC_URI="http://binaries.openttd.org/releases/${MY_PV}/${MY_P}-source.tar.bz2"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug dedicated iconv icu lzo +openmedia +png +truetype zlib"
RESTRICT="test"

DEPEND="
	!dedicated? (
		media-libs/libsdl[audio,X,video]
		icu? ( dev-libs/icu )
		truetype? (
			media-libs/fontconfig
			media-libs/freetype:2
			sys-libs/zlib
		)
	)
	lzo? ( dev-libs/lzo:2 )
	iconv? ( virtual/libiconv )
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	!dedicated? (
		alsa? ( media-sound/alsa-utils )
	)"
PDEPEND="
	openmedia? (
		games-misc/opengfx
		games-misc/opensfx
		games-misc/openmsx
	)"

src_configure() {
	# there is an allegro interface available as well as sdl, but
	# the configure for it looks broken so the sdl interface is
	# always built instead.
	local myopts="${myopts} --without-allegro"

	use debug && myopts="${myopts} --enable-debug=3"

	if use dedicated ; then
		myopts="${myopts} --enable-dedicated"
	else
		use alsa && myopts="${myopts} --with-midi=/usr/bin/aplaymidi"
		myopts="${myopts}
			$(use_with truetype freetype)
			$(use_with icu)
			--with-sdl"
	fi
	if use png || { use !dedicated && use truetype; } || use zlib ; then
		myopts="${myopts} --with-zlib"
	else
		myopts="${myopts} --without-zlib"
	fi

	# configure is a hand-written bash-script, so econf will not work.
	# It's all built as C++, upstream uses CFLAGS internally.
	CFLAGS="" ./configure \
		--disable-strip \
		--prefix-dir="${EPREFIX}" \
		--binary-dir="${GAMES_BINDIR}" \
		--data-dir="${GAMES_DATADIR}/${PN}" \
		--install-dir="${D}" \
		--icon-dir=/usr/share/pixmaps \
		--menu-dir=/usr/share/applications \
		--icon-theme-dir=/usr/share/icons/hicolor \
		--man-dir=/usr/share/man/man6 \
		--doc-dir=/usr/share/doc/${PF} \
		--menu-group="Game;Simulation;" \
		${myopts} \
		$(use_with iconv) \
		$(use_with png) \
		$(use_with lzo liblzo2) \
		|| die "configure failed"
}

src_compile() {
	emake VERBOSE=1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use dedicated ; then
		newinitd "${FILESDIR}"/${PN}.initd ${PN}
		rm -rf "${D}"/usr/share/{applications,icons,pixmaps}
	fi
	rm -f "${D}"/usr/share/doc/${PF}/COPYING
	prepalldocs
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use openmedia ; then
		elog
		elog "OpenTTD was compiled without openmedia USE flags."
		elog
		elog "In order to play, you must either install games-misc/opengfx"
		elog "as well as games-misc/opensfx or copy the following 6 files"
		elog "from a version of Transport Tycoon Deluxe (windows or DOS)"
		elog "to ~/.openttd/data/ or ${GAMES_DATADIR}/${PN}/data/."
		elog
		elog "From the WINDOWS version you need: "
		elog "  sample.cat trg1r.grf trgcr.grf trghr.grf trgir.grf trgtr.grf"
		elog "OR from the DOS version you need: "
		elog "  SAMPLE.CAT TRG1.GRF TRGC.GRF TRGH.GRF TRGI.GRF TRGT.GRF"
		elog
		elog "File names are case sensitive so make sure they are "
		elog "correct for whichever version you have."
		elog
	fi

	if ! use lzo ; then
		elog "OpenTTD was compiled without lzo2 support."
		elog "While lzo2 is not required, disabling it does mean that"
		elog "loading old savegames/scenarios from ancient versions (~0.2)"
		elog "will be disabled"
		elog
	fi

	if use dedicated ; then
		ewarn "Warning: The init script will kill all running openttd"
		ewarn "processes when run, including any running client sessions!"
	else
		if use alsa ; then
			elog "You have emerged with 'aplaymidi' for playing MIDI."
			elog "You have to set the environment variable ALSA_OUTPUT_PORTS."
			elog "Available ports can be listed by using 'aplaymidi -l'."
			if ! use openmedia ; then
				elog "You have disabled the openmedia use flag, in-game music"
				elog "will be unavailable unless you install games-misc/openmsx"
				elog "or install a music set in ~/.openttd/gm or use the in-game"
				elog "download functionality to get a music set"
			fi
		else
			elog "alsa not in USE so music will not be played during the game."

		fi
	fi
}
