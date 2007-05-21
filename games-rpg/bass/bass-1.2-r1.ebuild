# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/bass/bass-1.2-r1.ebuild,v 1.1 2007/05/21 22:57:54 tupone Exp $

inherit eutils games

DESCRIPTION="Beneath a Steel Sky: a science fiction thriller set in a bleak vision of the future"
#HOMEPAGE="http://www.revgames.com/_display.php?id=16"
HOMEPAGE="http://en.wikipedia.org/wiki/Beneath_a_Steel_Sky"
SRC_URI="mirror://sourceforge/scummvm/bass-cd-${PV}.zip
	mirror://gentoo/${PN}.png"

LICENSE="bass"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=games-engines/scummvm-0.5.0"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/bass-cd-${PV}

src_install() {
	games_make_wrapper bass "scummvm -f -p \"${GAMES_DATADIR}/${PN}\" sky" .
	insinto "${GAMES_DATADIR}"/${PN}
	doins sky.* || die "doins failed"
	dodoc readme.txt
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} "Beneath a Steel Sky" ${PN}.png
	prepgamesdirs
}
