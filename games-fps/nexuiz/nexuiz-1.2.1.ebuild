# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/nexuiz/nexuiz-1.2.1.ebuild,v 1.4 2006/01/13 21:57:52 dertobi123 Exp $

inherit eutils games

DESCRIPTION="a free deathmatch FPS based on the Quake I engine"
HOMEPAGE="http://www.nexuiz.com"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV//./}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="dedicated sdl"

RDEPEND="virtual/opengl
	sdl? ( media-libs/libsdl )
	media-libs/libogg
	media-libs/libvorbis
	media-libs/jpeg
	media-libs/alsa-lib
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}/${PN/n/N}

src_unpack() {
	unpack ${A}
	cd "${S}"
	unzip $(ls nexuizenginesource* | head -n 1)

	cd darkplaces
	sed -i \
		-e "/strcpy(fs_basedir/s:\.:${GAMES_DATADIR}/${PN}:" \
		fs.c \
		|| die "sed failed"

	sed -i \
		-e '/^CC/d' \
		-e "s:-lasound:$(pkg-config --libs alsa):" \
		-e 's:darkplaces-sdl:nexuiz-sdl:' \
		-e 's:darkplaces-glx:nexuiz-glx:' \
		-e 's:darkplaces-dedicated:nexuiz-dedicated:' \
		makefile.inc \
		|| die "sed failed"
}

src_compile() {
	cd darkplaces

	emake cl-release \
		CFLAGS_RELEASE="" OPTIM_RELEASE="" \
		CFLAGS_COMMON="${CFLAGS}" \
		|| die "emake cl-release failed"

	if use sdl;	then
		emake sdl-release \
			CFLAGS_RELEASE="" OPTIM_RELEASE="" \
			CFLAGS_COMMON="${CFLAGS}" \
			|| die "emake sdl-release failed"
	fi

	if use dedicated; then
		emake sv-release \
			CFLAGS_RELEASE="" OPTIM_RELEASE="" \
			CFLAGS_COMMON="${CFLAGS}" \
			|| die "emake dedicated failed"
	fi
}

src_install() {
	dogamesbin darkplaces/nexuiz-glx || die "dogamesbin failed"
	if use sdl; then
		dogamesbin darkplaces/nexuiz-sdl || die "dogamesbin failed"
	fi
	if use dedicated; then
		dogamesbin darkplaces/nexuiz-dedicated || die "dogamesbin failed"
	fi

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/ || die "doins failed"
	newicon darkplaces/darkplaces72x72.png ${PN}.png

	if use sdl; then
		make_desktop_entry nexuiz-sdl "Nexuiz" ${PN}.png
	else
		make_desktop_entry nexuiz-glx "Nexuiz" ${PN}.png
	fi
	prepgamesdirs
}
