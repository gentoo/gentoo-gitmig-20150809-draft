# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/methane/methane-1.4.6.ebuild,v 1.8 2004/08/03 11:51:19 dholm Exp $

inherit games

DESCRIPTION="Port from an old amiga game"
HOMEPAGE="http://www.methane.fsnet.co.uk/"
SRC_URI="http://www.methane.fsnet.co.uk/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~amd64 ~ppc"
IUSE="mikmod"

RDEPEND="=dev-games/clanlib-0.6.5*
	mikmod? ( media-libs/libmikmod )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	clanlib-config 0.6.5
}

src_unpack() {
	unpack ${A}
	cd ${S}/source/linux
	if ! use mikmod ; then
		sed -i \
			-e 's/^\(MIKMOD_LIBS\)/#\1/g' \
			-e 's/^\(METHANE_FLAGS\)/#\1/g' makefile \
				|| die "mikmod sed failed"
	fi
}

src_compile() {
	cd source/linux
	emake -j1 || die "emake failed"
}

src_install() {
	dogamesbin source/linux/methane || die "dogamesbin failed"
	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}/methanescores"
	dodoc authors copying history install todo
	dohtml ${S}/docs/*
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/methanescores"
}
