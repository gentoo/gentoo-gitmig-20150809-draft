# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/racer-bin/racer-bin-0.5.0-r1.ebuild,v 1.1 2003/09/11 12:26:35 vapier Exp $

inherit games

DESCRIPTION="A car simulation game focusing on realism, in the style of Grand Prix Legends"
HOMEPAGE="http://www.racer.nl/"
SRC_URI="http://download.tdconline.dk/pub/boomtown/racesimcentral/rr_data${PV}.tgz
	http://download.tdconline.dk/pub/boomtown/racesimcentral/rr_bin_linux${PV}.tgz"

LICENSE="Racer"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="virtual/opengl
	media-libs/libsdl
	sys-libs/lib-compat
	>=media-libs/fmod-3.61"

S=${WORKDIR}/racer${PV}

src_compile() {
	einfo "Binary package. Nothing to compile"
}

src_install( ) {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	dodoc *.txt ; rm *.txt
	cp -R ${S}/* ${D}/${dir}/

	sed -e "s:GENTOO_DIR:${dir}:" ${FILESDIR}/racer-skel > racer-skel
	for bin in carlab gplex modeler pacejka racer tracked ; do
		newgamesbin racer-skel ${bin}
		dosed "s:GENTOO_BIN:${bin}:" ${GAMES_BINDIR}/${bin}
	done

	local libfmod=`find /usr/lib/ -name 'libfmod-*so' -maxdepth 1 -type f -printf '%f'`
	dosym /usr/lib/${libfmod} ${dir}/bin/libfmod-3.61.so
	dosym /usr/lib/${libfmod} ${dir}/bin/libfmod-3.5.so

	prepgamesdirs
}
