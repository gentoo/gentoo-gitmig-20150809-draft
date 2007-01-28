# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wipe/wipe-2.2.0.ebuild,v 1.12 2007/01/28 05:32:15 genone Exp $

DESCRIPTION="Secure file wiping utility based on Peter Gutman's patterns"
HOMEPAGE="http://wipe.sourceforge.net/"
SRC_URI="mirror://sourceforge/wipe/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 sparc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	dobin wipe || die "dobin failed"
	doman wipe.1
	dodoc CHANGES README TODO TESTING
}

pkg_postinst() {
	elog "Note that wipe is useless on journalling filesystems, such as reiserfs or XFS."
	elog "See documentation for more info."
}
