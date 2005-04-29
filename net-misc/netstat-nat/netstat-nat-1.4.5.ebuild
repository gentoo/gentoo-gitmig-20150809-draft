# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netstat-nat/netstat-nat-1.4.5.ebuild,v 1.1 2005/04/29 15:04:26 vanquirius Exp $

DESCRIPTION="Display NAT connections"
HOMEPAGE="http://tweegy.demon.nl/projects/netstat-nat/index.html"
SRC_URI="http://tweegy.demon.nl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die
}
