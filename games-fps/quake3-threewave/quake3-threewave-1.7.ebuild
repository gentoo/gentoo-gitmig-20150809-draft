# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-threewave/quake3-threewave-1.7.ebuild,v 1.1 2004/11/23 22:06:44 wolf31o2 Exp $

MOD_DESC="Threewave CTF"
MOD_NAME=threewave
inherit games games-q3mod

HOMEPAGE="http://www.threewave.com/"
SRC_URI="threewave_16_full.zip
	threewave_${PV//./}_update.zip"

LICENSE="as-is"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download ${A} and put it into ${DISTDIR}"
	einfo "http://www.planetquake3.net/download.php?op=viewsdownload&sid=37"
}

src_unpack() {
	unpack threewave_16_full.zip
	unpack threewave_${PV//./}_update.zip
}
