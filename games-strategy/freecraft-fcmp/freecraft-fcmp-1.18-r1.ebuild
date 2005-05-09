# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecraft-fcmp/freecraft-fcmp-1.18-r1.ebuild,v 1.6 2005/05/09 14:53:28 dholm Exp $

inherit games

FCMP_VER=030311
MUSIC_VER=030226
DESCRIPTION="A collection of graphic/sound files to replace the data files from a real WarCraft CD"
HOMEPAGE="http://www.freecraft.org/"
SRC_URI="fcmp-${FCMP_VER}.tar.gz
	music? ( music-pack-${MUSIC_VER}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="music"
RESTRICT="fetch"

DEPEND="=games-strategy/freecraft-1.18*"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Due to a Ceast and Desist given by Blizzard,"
	einfo "you must obtain the sources for this game yourself."
	einfo "For more information, please visit: ${HOMEPAGE}"
	einfo "Also, you'll have to place the files ${A}"
	einfo "into ${DISTDIR}"
}

src_install() {
	dohtml data/ChangeLog.html && rm data/ChangeLog.html
	dodir ${GAMES_DATADIR}/freecraft/
	cp -r ${S}/data ${D}/${GAMES_DATADIR}/freecraft/
	prepgamesdirs
}
