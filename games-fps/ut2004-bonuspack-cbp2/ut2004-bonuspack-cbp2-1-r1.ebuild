# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-cbp2/ut2004-bonuspack-cbp2-1-r1.ebuild,v 1.5 2009/10/01 22:03:08 nyhm Exp $

MOD_DESC="Community Bonus Pack 2 volumes 1 and 2"
MOD_NAME="Community Bonus Pack 2 volumes 1 and 2"
MOD_TBZ2="cbp2_volume1 cbp2_volume2"

inherit games games-mods

HOMEPAGE="http://www.planetunreal.com/cbp/"
SRC_URI="mirror://liflg/cbp2_volume1-multilanguage.run
	mirror://liflg/cbp2_volume2-multilanguage.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

RDEPEND="games-fps/ut2004-bonuspack-cbp1"

src_unpack() {
	games-mods_src_unpack
	rm -f unpack/Music/Soeren.ogg # cbp1 collision
}
