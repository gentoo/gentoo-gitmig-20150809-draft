# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-wop/quake3-wop-1.0_beta1-r2.ebuild,v 1.1 2006/10/25 15:42:01 wolf31o2 Exp $

MOD_DESC="the biggest Q3A-Funmod project"
MOD_NAME="World of Padman"
MOD_DIR="wop"

inherit games games-mods

HOMEPAGE="http://www.worldofpadman.com"
SRC_URI="http://www.unixforces.net/downloads/wop.zip
	http://ftp.wireplay.co.uk/pub/quake3arena/mods/padmod/patches/win32/wop.zip
	http://www.unixforces.net/downloads/wop_update01.zip"

LICENSE="freedist"
RESTRICT="fetch mirror strip"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"

pkg_nofetch() {
	einfo "Go to http://padworld.myexp.de/index_e.php?page=files/files.html"
	einfo "and download ${A}"
}
