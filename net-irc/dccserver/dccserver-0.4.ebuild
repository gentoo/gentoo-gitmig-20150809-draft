# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dccserver/dccserver-0.4.ebuild,v 1.6 2004/07/12 22:21:03 swegener Exp $

DESCRIPTION="linux implementation of the mirc dccserver command"
SRC_URI="http://www.nih.at/dccserver/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
HOMEPAGE="http://www.nih.at/dccserver/"

DEPEND="virtual/libc"

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS NEWS THANKS TODO
}
