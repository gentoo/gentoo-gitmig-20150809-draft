# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/raptor2/raptor2-1.0.0.ebuild,v 1.3 2004/03/19 17:49:46 agriffis Exp $

inherit eutils games

MY_P="raptor-${PV}"
DESCRIPTION="space shoot-em-up game"
SRC_URI="mirror://sourceforge/raptorv2/${MY_P}.tar.gz"
HOMEPAGE="http://raptorv2.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ia64"
IUSE="oggvorbis nls"

DEPEND=">=sys-apps/sed-4"
RDEPEND=">=media-libs/allegro-4.0.0
	=media-libs/dumb-0.9.1"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/${PV}-chdir.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		src/raptor.cpp || die "sed src/raptor.cpp failed"
}

src_compile() {
	egamesconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	dogamesbin src/raptor

	insinto ${GAMES_DATADIR}/${PN}/data
	doins data/*

	dodoc AUTHORS ChangeLog README NEWS

	prepgamesdirs
}
