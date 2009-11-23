# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.102.2.ebuild,v 1.3 2009/11/23 03:11:25 mr_bones_ Exp $

EAPI=2
inherit flag-o-matic eutils games

MY_PV=${PV/0./}
MY_PV=${MY_PV/./-}
DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.com/"
SRC_URI="mirror://sourceforge/simutrans/simutrans-src-${MY_PV}.zip
	mirror://sourceforge/simutrans/files/Simutrans%20complete/${MY_PV}/simulinux-complete-${MY_PV}.zip
	mirror://sourceforge/simutrans/files/pak64/simupak64-addon-food-${MY_PV}.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,video]
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_prepare() {
	strip-flags # bug #293927
	echo "BACKEND=mixer_sdl
COLOUR_DEPTH=16
OSTYPE=linux
FLAGS=-DSTEPS16" > config.default \
	|| die "echo failed"

	if use amd64; then
		echo "FLAGS+=-DUSE_C" >> config.default
	fi
	# make it look in the install location for the data
	sed -i \
		-e "s:argv\[0\]:\"${GAMES_DATADIR}/${PN}/\":" \
		simmain.cc \
		|| die "sed failed"

	# Please don't override our CFLAGS, kthx
	sed -i \
		-e '/-O$/d' \
		Makefile \
		|| die "sed failed"

	rm -f simutrans/simutrans
}

src_install() {
	newgamesbin sim ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r simutrans/* || die "doins failed"
	dodoc documentation/* todo.txt
	doicon simutrans.ico
	make_desktop_entry simutrans Simutrans /usr/share/pixmaps/simutrans.ico
	prepgamesdirs
}
