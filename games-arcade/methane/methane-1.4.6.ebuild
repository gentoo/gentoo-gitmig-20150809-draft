# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/methane/methane-1.4.6.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $ 

inherit games

DESCRIPTION="Port from a old amiga game."
HOMEPAGE="http://www.methane.fsnet.co.uk/"
SRC_URI="http://www.methane.fsnet.co.uk/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mikmod"

DEPEND="=dev-games/clanlib-0.6.5*
	mikmod? ( media-libs/libmikmod )
	>=sys-apps/sed-4"

pkg_setup() {
	clanlib-config 0.6.5
}

src_unpack() {
	unpack ${A}
	cd ${S}/source/linux
	if [ ! `use mikmod` ] ; then
		sed -i \
			-e 's/^\(MIKMOD_LIBS\)/#\1/g' \
			-e 's/^\(METHANE_FLAGS\)/#\1/g' \
			makefile || die "mikmod sed failed"
	fi
}

src_compile() {
	cd source/linux
	emake -j1 || die
}

src_install() {
	dogamesbin source/linux/methane || die "couldnt install methane"
	dodir ${GAMES_STATEDIR}
	touch ${D}/${GAMES_STATEDIR}/methanescores
	dodoc authors copying history install todo
	dohtml ${S}/docs/*
	prepgamesdirs
	fperms g+w ${GAMES_STATEDIR}/methanescores
}
