# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-bfp/quake3-bfp-1.2.ebuild,v 1.2 2004/12/29 06:03:09 mr_bones_ Exp $

MOD_DESC="Bid For Power"
MOD_NAME=bfpq3
MOD_BINS=bfp
inherit games games-q3mod

HOMEPAGE="http://www.planetquake.com/bidforpower/"
SRC_URI="bidforpower${PV/./-}.zip"

LICENSE="Q3AEULA"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please goto ${HOMEPAGE}"
	einfo "and download ${A} into ${DISTDIR}"
}
