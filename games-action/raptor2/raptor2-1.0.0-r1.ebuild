# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/raptor2/raptor2-1.0.0-r1.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit eutils games

MY_P="raptor-${PV}"
DESCRIPTION="space shoot-em-up game"
SRC_URI="mirror://sourceforge/raptorv2/${MY_P}.tar.gz"
HOMEPAGE="http://raptorv2.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="oggvorbis nls"

RDEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/aldumb-0.9.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/${PV}-chdir.patch
	cd src && cp raptor.cpp{,.orig}
	sed -e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		raptor.cpp.orig > raptor.cpp
}

src_install() {
	dogamesbin src/raptor
	insinto ${GAMES_DATADIR}/${PN}/data
	doins data/*
	dodoc AUTHORS ChangeLog README NEWS
	prepgamesdirs
}

