# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-threewave/quake3-threewave-1.6.ebuild,v 1.5 2004/06/24 22:45:39 agriffis Exp $

MOD_DESC="Threewave CTF"
MOD_NAME=threewave
inherit games games-q3mod

HOMEPAGE="http://www.threewave.com/"
SRC_URI="threewave_${PV//.}_full.zip"

LICENSE="as-is"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download ${A} and put it into ${DISTDIR}"
	einfo "http://www.planetquake3.net/download.php?op=viewdownloaddetails&lid=1137"
}
