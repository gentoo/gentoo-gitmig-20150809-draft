# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/raptor2/raptor2-1.0.0-r1.ebuild,v 1.13 2006/12/05 18:11:16 wolf31o2 Exp $

inherit eutils games

MY_P="raptor-${PV}"
DESCRIPTION="space shoot-em-up game"
HOMEPAGE="http://raptorv2.sourceforge.net/"
SRC_URI="mirror://sourceforge/raptorv2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/aldumb-0.9.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/${PV}-chdir.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" src/raptor.cpp \
			|| die "sed src/raptor.cpp failed"
}

src_install() {
	dogamesbin src/raptor || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}/data"
	doins data/* || die "doins failed"
	dodoc AUTHORS ChangeLog README NEWS
	prepgamesdirs
}
