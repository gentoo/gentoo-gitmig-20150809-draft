# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/racer-bin/racer-bin-0.5.0-r1.ebuild,v 1.3 2004/03/20 12:59:58 mr_bones_ Exp $

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
	local f
	dodir ${dir} || die "dodir failed"

	dodoc *.txt || die "dodoc failed"
	rm -f *.txt
	cp -R ${S}/* ${D}/${dir}/ || die "cp failed"

	sed -e "s:GENTOO_DIR:${dir}:" ${FILESDIR}/racer-skel > racer-skel || \
		die "sed failed"

	for f in carlab gplex modeler pacejka racer tracked
	do
		newgamesbin racer-skel ${f} || \
			die "newgamesbin ${f} failed"
		dosed "s:GENTOO_BIN:${f}:" ${GAMES_BINDIR}/${f} || \
			die "dosed ${f} failed"
	done

	local libfmod=`find /usr/lib/ -name 'libfmod-*so' -maxdepth 1 -type f -printf '%f'`
	dosym /usr/lib/${libfmod} ${dir}/bin/libfmod-3.61.so
	dosym /usr/lib/${libfmod} ${dir}/bin/libfmod-3.5.so

	# Fix up some permissions for bug 31694
	for f in racer.ini data/drivers/default/driver.ini data/tracks/carlswood_nt/bestlaps.ini
	do
		fperms 664 ${dir}/${f} || \
			die "fperms ${f} failed"
	done

	prepgamesdirs
}
