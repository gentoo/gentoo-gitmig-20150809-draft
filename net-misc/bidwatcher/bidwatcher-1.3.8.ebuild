# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bidwatcher/bidwatcher-1.3.8.ebuild,v 1.1 2003/06/18 21:17:19 msterret Exp $

IUSE=""

DESCRIPTION="eBay auction watcher and sniper agent"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bidwatcher.sourceforge.net/"

KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"

src_install() {
	einstall || die
	dodoc README COPYING NEWS AUTHORS ChangeLog
	dohtml quick_start.html
}
