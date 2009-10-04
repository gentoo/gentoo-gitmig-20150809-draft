# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-cbp2/ut2004-bonuspack-cbp2-1-r1.ebuild,v 1.6 2009/10/04 13:31:23 nyhm Exp $

EAPI=2

MOD_DESC="Community Bonus Pack 2 volumes 1 and 2"
MOD_NAME="Community Bonus Pack 2 volumes 1 and 2"
MOD_TBZ2="cbp2_volume1 cbp2_volume2"
MOD_NO_DED="1"

inherit games games-mods

HOMEPAGE="http://www.planetunreal.com/cbp/"
SRC_URI="mirror://liflg/cbp2_volume1-multilanguage.run
	mirror://liflg/cbp2_volume2-multilanguage.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="games-fps/ut2004-bonuspack-cbp1"

src_unpack() {
	games-mods_src_unpack
	rm -f unpack/Music/Soeren.ogg # cbp1 collision
}
