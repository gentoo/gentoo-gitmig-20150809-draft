# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/methane/methane-1.4.7.ebuild,v 1.3 2007/03/23 16:48:34 nyhm Exp $

inherit games

DESCRIPTION="Port from an old amiga game"
HOMEPAGE="http://methane.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mikmod"

DEPEND="=dev-games/clanlib-0.7*
	mikmod? ( >=media-libs/libmikmod-3.1.11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if ! use mikmod ; then
		sed -i \
			-e '/^METHANE_SND/s/^/#/' \
			source/linux/makefile \
			|| die "sed failed"
	fi
	sed -i \
		-e "s:/var/games:${GAMES_STATDIR}:" \
		source/linux/doc.cpp history \
		|| die "sed failed"
}

src_compile() {
	emake -C source/linux -j1 || die "emake failed"
}

src_install() {
	dogamesbin source/linux/methane || die "dogamesbin failed"
	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}/methanescores"
	dodoc authors history install todo
	dohtml "${S}"/docs/*
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/methanescores"
}
