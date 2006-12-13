# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-muralis/ut2004-muralis-1.15.ebuild,v 1.1 2006/12/13 21:17:22 wolf31o2 Exp $

MOD_DESC="third-person hand-to-hand single/multiplayer mod"
MOD_NAME="Muralis"
MOD_DIR="muralis"

inherit games games-mods

HOMEPAGE="http://www.ascensiongames.com/"

MOD_FILE="muralis-v${PV}-zip.zip"
SRC_URI="mirror://beyondunreal/mods/${MOD_FILE}"

LICENSE="freedist"

KEYWORDS="~amd64 ~x86"

RDEPEND="${CATEGORY}/${GAME}"

src_unpack() {
	unzip "${DISTDIR}"/${MOD_FILE}
	mv ${MOD_NAME} ${MOD_DIR}
}
