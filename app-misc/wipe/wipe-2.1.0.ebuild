# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wipe/wipe-2.1.0.ebuild,v 1.5 2003/07/01 22:31:32 aliz Exp $

DESCRIPTION="Secure file wiping utility based on Peter Gutman's patterns"
SRC_URI="mirror://sourceforge/wipe/${P}.tar.bz2"
HOMEPAGE="http://wipe.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
    >=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i -e '28 i\#include <errno.h>' ${S}/rand.c || die "sed rand.c failed"
}

src_compile() {
	econf || die "econf failed"
	emake || die "compile problem"
}

src_install() {
	dobin wipe
	doman wipe.1
	dodoc copyright CHANGES README TODO TESTING
}

pkg_postinst() {
	einfo "Note that wipe is useless on journalling filesystems, such as reiserfs or XFS."
	einfo "See documentation for more info."
}
