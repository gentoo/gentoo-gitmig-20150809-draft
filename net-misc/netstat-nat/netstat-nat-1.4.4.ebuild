# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netstat-nat/netstat-nat-1.4.4.ebuild,v 1.3 2005/02/25 12:07:50 ka0ttic Exp $

DESCRIPTION="Display NAT connections"
HOMEPAGE="http://tweegy.demon.nl/projects/netstat-nat/index.html"
SRC_URI="http://tweegy.demon.nl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="sparc x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	emake DESTDIR=${D} install || die
}
