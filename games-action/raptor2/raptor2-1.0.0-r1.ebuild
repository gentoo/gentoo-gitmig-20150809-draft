# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/raptor2/raptor2-1.0.0-r1.ebuild,v 1.4 2004/03/19 17:49:46 agriffis Exp $

inherit eutils games

MY_P="raptor-${PV}"
DESCRIPTION="space shoot-em-up game"
HOMEPAGE="http://raptorv2.sourceforge.net/"
SRC_URI="mirror://sourceforge/raptorv2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ia64"
IUSE="oggvorbis nls"

RDEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/aldumb-0.9.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/${PV}-chdir.patch
	sed -i \
		"s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		src/raptor.cpp
}

src_install() {
	dogamesbin src/raptor
	insinto ${GAMES_DATADIR}/${PN}/data
	doins data/*
	dodoc AUTHORS ChangeLog README NEWS
	prepgamesdirs
}
