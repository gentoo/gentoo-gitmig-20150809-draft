# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wipe/wipe-2.1.0.ebuild,v 1.2 2002/11/30 21:39:08 vapier Exp $

DESCRIPTION="Secure file wiping utility based on Peter Gutman's patterns"
SRC_URI="mirror://sourceforge/wipe/${P}.tar.bz2"
HOMEPAGE="http://wipe.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	econf
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
