# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-nsco/quake3-nsco-1.91.ebuild,v 1.1 2004/02/28 21:08:35 vapier Exp $

MOD_DESC="Navy Seals : Covert Operations"
MOD_NAME=seals
MOD_BINS=nsco
inherit games games-q3mod

HOMEPAGE="http://ns-co.net/"
SRC_URI="nsco_beta19.zip
	nsco_beta191upd.zip"

LICENSE="Q3AEULA"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please goto ${HOMEPAGE}"
	einfo "and download ${A} into ${DISTDIR}"
}
