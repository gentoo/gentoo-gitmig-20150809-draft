# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

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
