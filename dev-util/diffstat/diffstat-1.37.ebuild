# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffstat/diffstat-1.37.ebuild,v 1.3 2005/01/25 11:59:46 ka0ttic Exp $

inherit eutils

DESCRIPTION="diffstat reads the output of diff and displays a histogram of the insertions, deletions, and modifications per-file"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"
HOMEPAGE="http://invisible-island.net/diffstat/diffstat.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~sparc ~ppc ~mips ~amd64 ~ia64 ~alpha"
IUSE=""

DEPEND="sys-apps/diffutils"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-hard-locale.patch
}

src_install() {
	dobin diffstat || die "dobin failed"
	doman diffstat.1 || die "doman failed"
	dodoc README CHANGES || die "dodoc failed"
}
