# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecraft-fcmp/freecraft-fcmp-1.18-r1.ebuild,v 1.2 2003/09/10 05:59:44 vapier Exp $

inherit games

FCMP_VER=030311
MUSIC_VER=030226
DESCRIPTION="A collection of graphic/sound files to replace the data files from a real WarCraft CD"
SRC_URI="mirror://sourceforge/freecraft/fcmp-${FCMP_VER}.tar.gz
	music? ( mirror://sourceforge/freecraft/music-pack-${MUSIC_VER}.tar.gz )"
HOMEPAGE="http://freecraft.sourceforge.org/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="music"

DEPEND="=games-strategy/freecraft-1.18*"

S=${WORKDIR}

src_install() {
	dohtml data/ChangeLog.html && rm data/ChangeLog.html
	dodir ${GAMES_DATADIR}/freecraft/
	cp -r ${S}/data ${D}/${GAMES_DATADIR}/freecraft/
	prepgamesdirs
}
