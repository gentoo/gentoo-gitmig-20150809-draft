# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-hamsterbash/ut2004-hamsterbash-1.ebuild,v 1.1 2007/01/31 16:03:31 wolf31o2 Exp $

MOD_DESC="Cute and violent hamster cage rampage mod"
MOD_NAME="Hamster Bash"
MOD_DIR="hamsterbash"

inherit games games-mods

HOMEPAGE="http://www.eigensoft.com/hamsterbash.htm"
SRC_URI="http://server088.eigensoft.com/HamsterBashFinal.zip"

LICENSE="freedist"

KEYWORDS="~amd64 ~x86"

RDEPEND="${CATEGORY}/${GAME}"

src_unpack() {
	unzip "${DISTDIR}"/HamsterBashFinal.zip
	mv -f HamsterBash ${MOD_DIR}
}
