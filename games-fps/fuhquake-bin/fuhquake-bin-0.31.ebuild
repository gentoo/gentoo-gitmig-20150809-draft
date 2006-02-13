# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/fuhquake-bin/fuhquake-bin-0.31.ebuild,v 1.4 2006/02/13 22:16:11 tupone Exp $

inherit games

DESCRIPTION="quakeworld client with a plethora of gameplay/console/graphical improvements"
HOMEPAGE="http://www.fuhquake.net/"
SRC_URI="http://www.fuhquake.net/files/releases/v${PV}/fuhquake-linux-v${PV}.zip
	http://www.fuhquake.net/files/releases/v${PV}/fuhquake-security-v${PV}.zip
	http://maps.quakeworld.nu/locs/download/fuhquake_locs.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl svga"

RDEPEND="!svga? (
				  || (
					   x11-libs/libXext
					   virtual/x11
					 )
				)
	svga? ( media-libs/svgalib )
	opengl? (
			  virtual/opengl
			  || (
				    x11-libs/libXext
					virtual/x11
				 )
			)"
DEPEND="${RDEPEND}
		app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack fuhquake-linux-v${PV}.zip fuhquake-security-v${PV}.zip
	rm -f gnu.txt fuhquake-security.dll
	mkdir qw/locs && cd qw/locs
	unpack fuhquake_locs.zip
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN} BINS
	dodir "${dir}"

	exeinto "${dir}"
	if use opengl; then
		BINS="fuhquake-gl.glx fuhquake.x11"
	elif ! use svga; then
		# X will be built if neither opengl nor svga
		BINS="fuhquake.x11"
	fi
	if use svga; then
		BINS="${BINS} fuhquake.svga"
	fi

	doexe ${BINS} fuhquake-security.so || die "doexe"
	cp -r fuhquake qw "${D}/${dir}"/ || die "cp data"
	dosym "${GAMES_DATADIR}"/quake1/id1 "${dir}"/id1

	for x in ${BINS}; do
		games_make_wrapper ${x} ./${x} "${dir}"
	done

	prepgamesdirs
}
