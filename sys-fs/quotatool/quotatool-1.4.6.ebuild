# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/quotatool/quotatool-1.4.6.ebuild,v 1.2 2004/10/17 10:01:31 dholm Exp $

DESCRIPTION="command-line utility for filesystem quotas"
HOMEPAGE="http://quotatool.ekenberg.se/"
SRC_URI="http://quotatool.ekenberg.se/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="sys-fs/quota"

src_install () {
	dobin quotatool || die
	doman man/quotatool.8
	dodoc AUTHORS ChangeLog README TODO
}
