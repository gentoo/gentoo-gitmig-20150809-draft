# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/net-misc/kift/kift-0.8.1.ebuild,v 1.1 2002/05/30 20:48:01 verwilst Exp

inherit kde-base || die

need-kde 3

DESCRIPTION="KDE interface for giFT"
HOMEPAGE="http://kift.sourceforge.net"

newdepend ">=net-p2p/gift-0.10.0_pre020527"

SRC_URI="mirror://sourceforge/kift/${P}.tar.gz"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff

}
