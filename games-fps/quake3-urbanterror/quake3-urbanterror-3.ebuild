# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-urbanterror/quake3-urbanterror-3.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME=q3ut3
inherit games games-q3mod

SRC_URI="urbanterror3.zip"
HOMEPAGE="http://www.urbanterror.net/"

SLOT="3"
LICENSE="freedist"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please goto ${HOMEPAGE}"
	einfo "and download ${A} into ${DISTDIR}"
}
