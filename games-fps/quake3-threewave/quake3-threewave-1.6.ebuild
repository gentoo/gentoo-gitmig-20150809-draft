# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-threewave/quake3-threewave-1.6.ebuild,v 1.4 2004/02/20 06:40:07 mr_bones_ Exp $

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
