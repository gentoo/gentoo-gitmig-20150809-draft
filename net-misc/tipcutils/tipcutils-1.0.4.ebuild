# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tipcutils/tipcutils-1.0.4.ebuild,v 1.1 2007/01/26 19:07:09 gustavoz Exp $

DESCRIPTION="Utilities for TIPC (Transparent Inter-Process Communication)"
HOMEPAGE="http://tipc.sourceforge.net/"
SRC_URI="mirror://sourceforge/tipc/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install () {
	dosbin tipc-config
}
