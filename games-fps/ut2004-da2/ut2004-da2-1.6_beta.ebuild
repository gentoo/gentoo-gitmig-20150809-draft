# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-da2/ut2004-da2-1.6_beta.ebuild,v 1.1 2007/04/13 21:27:55 wolf31o2 Exp $

MOD_NAME="Defence Alliance 2"
MOD_DIR="DA2"
MOD_DESC="assault mod with improved bot AI"
MOD_BINS="da2"
MOD_ICON="defencealliance2.xpm"

inherit games games-mods

MY_PV=${PV/_beta/beta}

HOMEPAGE="http://www.planetunreal.com/da/2/"
# The 1.6 zipfile is unreable.
# http://forums.beyondunreal.com/showthread.php?t=178603&page=2
SRC_URI="http://home.coc-ag.de/dressler-ro/liflg/files/native/defence.alliance2_${MY_PV}-english.run"

# See Help/readme.txt
LICENSE="free-noncomm"

RDEPEND="${CATEGORY}/${GAME}"

src_unpack() {
	unpack_makeself
	unpack ./da2.tar.gz

	mv *.xpm "${MOD_DIR}" || die
}
