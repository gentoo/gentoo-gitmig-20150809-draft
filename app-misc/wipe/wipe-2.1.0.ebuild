# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wipe/wipe-2.1.0.ebuild,v 1.10 2004/06/28 04:17:54 vapier Exp $

DESCRIPTION="Secure file wiping utility based on Peter Gutman's patterns"
HOMEPAGE="http://wipe.sourceforge.net/"
SRC_URI="mirror://sourceforge/wipe/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i -e '28 i\#include <errno.h>' ${S}/rand.c || die "sed rand.c failed"
}

src_install() {
	dobin wipe || die
	doman wipe.1
	dodoc copyright CHANGES README TODO TESTING
}

pkg_postinst() {
	einfo "Note that wipe is useless on journalling filesystems, such as reiserfs or XFS."
	einfo "See documentation for more info."
}
