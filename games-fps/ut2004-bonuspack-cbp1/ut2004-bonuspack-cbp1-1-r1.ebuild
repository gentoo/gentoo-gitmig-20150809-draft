# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-bonuspack-cbp1/ut2004-bonuspack-cbp1-1-r1.ebuild,v 1.4 2009/10/04 13:26:41 nyhm Exp $

EAPI=2

MOD_DESC="original Community Bonus Pack for UT2003 repacked for UT2004"
MOD_NAME="Community Bonus Pack Volume 1"
MOD_TBZ2="cbp1_volume1"
MOD_NO_DED="1"

inherit games games-mods

HOMEPAGE="http://www.planetunreal.com/cbp/"
SRC_URI="mirror://liflg/cbp1_volume1-multilanguage-2.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE=""
