# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.8.ebuild,v 1.3 2004/11/20 03:27:09 weeve Exp $

DESCRIPTION="Determines where a given nameserver gets its information from"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
HOMEPAGE="http://www.mavetju.org/unix/general.php"

IUSE="ipv6"
KEYWORDS="x86 ~ppc sparc ~s390"
LICENSE="as-is"
SLOT="0"
DEPEND="virtual/libc"
RDEPEND=""

src_compile () {
	econf `use_enable ipv6` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGES
}

