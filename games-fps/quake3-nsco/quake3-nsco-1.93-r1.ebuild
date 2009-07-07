# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-nsco/quake3-nsco-1.93-r1.ebuild,v 1.3 2009/07/07 23:06:50 flameeyes Exp $

MOD_DESC="a US Navy Seals conversion mod"
MOD_NAME="Navy Seals: Covert Operations"
MOD_DIR="seals"
MOD_BINS="nsco"

inherit games games-mods

HOMEPAGE="http://ns-co.net/"
SRC_URI="nsco_beta191a.zip
	nsco_beta193upd.zip"

LICENSE="freedist"
RESTRICT="strip mirror fetch"

pkg_nofetch() {
	elog "Please goto ${HOMEPAGE}"
	elog "and download ${A} into ${DISTDIR}"
}
