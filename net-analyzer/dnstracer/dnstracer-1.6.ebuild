# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.6.ebuild,v 1.8 2004/07/08 22:49:14 eldad Exp $

DESCRIPTION="Determines where a given nameserver gets its information from"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
HOMEPAGE="http://www.mavetju.org/unix/general.php"

IUSE=""
KEYWORDS="x86 ~ppc"
LICENSE="as-is"
SLOT="0"
DEPEND="virtual/libc"
RDEPEND=""

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGES
}

