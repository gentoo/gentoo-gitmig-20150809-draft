# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bidwatcher/bidwatcher-1.3.16.ebuild,v 1.1 2004/09/12 11:49:05 mholzer Exp $


MY_P=${P/_rc/-rc}
DESCRIPTION="eBay auction watcher and sniper agent"
HOMEPAGE="http://bidwatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE=""

DEPEND="virtual/libc
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"

S="${WORKDIR}/${MY_P}"

src_install() {
	einstall || die
	dodoc README COPYING NEWS AUTHORS ChangeLog
	dohtml quick_start.html
}
