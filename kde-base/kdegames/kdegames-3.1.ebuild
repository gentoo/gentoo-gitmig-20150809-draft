# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.1.ebuild,v 1.4 2003/01/28 15:16:50 hannes Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"

KEYWORDS="x86 ppc"

src_unpack() {
	base_src_unpack
	cd ${S}
	use alpha && epatch ${FILESDIR}/${P}-alpha.diff
}
