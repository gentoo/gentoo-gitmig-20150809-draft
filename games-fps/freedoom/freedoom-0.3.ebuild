# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/freedoom/freedoom-0.3.ebuild,v 1.1 2005/01/03 21:39:59 vapier Exp $

inherit games

DESCRIPTION="Freedoom - Open Source Doom resources"
HOMEPAGE="http://freedoom.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedoom/freedoom-demo-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-iwad-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-graphics-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-levels-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-resource-wad-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-sounds-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-sprites-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-textures-${PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="!games-fps/doom-data"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	insinto ${GAMES_DATADIR}/doom-data
	doins */*.wad || die "doins wad"
	dodoc freedoom-resource-wad-${PV}/{CREDITS,ChangeLog,NEWS,README}
	prepgamesdirs
}
