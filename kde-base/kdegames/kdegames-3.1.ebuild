# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.1.ebuild,v 1.9 2003/02/15 20:56:25 weeve Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"
IUSE=""
KEYWORDS="x86 ppc sparc"

src_unpack() {
	kde_src_unpack
	cd ${S}
	use alpha && epatch ${FILESDIR}/${P}-alpha.diff
}
