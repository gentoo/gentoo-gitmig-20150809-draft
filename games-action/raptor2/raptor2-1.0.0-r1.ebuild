# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/raptor2/raptor2-1.0.0-r1.ebuild,v 1.8 2004/11/08 01:20:27 josejx Exp $

inherit eutils games

MY_P="raptor-${PV}"
DESCRIPTION="space shoot-em-up game"
HOMEPAGE="http://raptorv2.sourceforge.net/"
SRC_URI="mirror://sourceforge/raptorv2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ia64 ppc"
IUSE=""

RDEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/aldumb-0.9.2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

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
