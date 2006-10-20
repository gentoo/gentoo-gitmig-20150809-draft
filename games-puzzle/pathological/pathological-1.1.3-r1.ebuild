# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pathological/pathological-1.1.3-r1.ebuild,v 1.4 2006/10/20 00:23:05 nyhm Exp $

inherit eutils games

DESCRIPTION="An enriched clone of the game 'Logical' by Rainbow Arts"
HOMEPAGE="http://pathological.sourceforge.net/"
SRC_URI="mirror://sourceforge/pathological/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc"

DEPEND="doc? ( media-libs/netpbm )"
RDEPEND=">=dev-python/pygame-1.5.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./${PN}.6.gz

	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-music-py.patch

	if use doc ; then
		sed -i \
			-e '5,$ s/=/ /g' makehtml \
			|| die "sed makehtml failed"
	else
		echo "#!/bin/sh" > makehtml
	fi

	sed -i \
		-e "s:/usr/share/games:${GAMES_DATADIR}:" \
		pathological || die "sed pathological failed"

	sed -i \
		-e "s:/usr/lib/pathological/bin:${GAMES_LIBDIR}/${PN}:" \
		-e "s:/var/games:${GAMES_STATEDIR}:" \
		pathological.py || die "sed pathological.py failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	exeinto "${GAMES_LIBDIR}"/${PN}
	doexe write-highscores || die "doexe failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r circuits graphics music sounds ${PN}.py || die "doins data failed"

	insinto "${GAMES_STATEDIR}"
	doins ${PN}_scores || die "doins scores failed"

	dodoc changelog README TODO
	doman ${PN}.6
	use doc && dohtml -r html/*

	doicon ${PN}.xpm
	make_desktop_entry ${PN} Pathological ${PN}.xpm

	# remove some unneeded resource files
	rm -f "${D}/${GAMES_DATADIR}"/${PN}/graphics/*.xcf

	fperms 660 "${GAMES_STATEDIR}"/${PN}_scores
	fperms 750 "${GAMES_DATADIR}"/${PN}/${PN}.py
	prepgamesdirs
}
