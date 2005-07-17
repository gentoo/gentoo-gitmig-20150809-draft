# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/quotatool/quotatool-1.4.7.ebuild,v 1.1 2005/07/17 13:29:34 vapier Exp $

DESCRIPTION="command-line utility for filesystem quotas"
HOMEPAGE="http://quotatool.ekenberg.se/"
SRC_URI="http://quotatool.ekenberg.se/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="sys-fs/quota"

src_install () {
	dobin quotatool || die
	doman man/quotatool.8
	dodoc AUTHORS ChangeLog README TODO
}
