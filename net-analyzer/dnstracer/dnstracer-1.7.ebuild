# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.7.ebuild,v 1.9 2005/01/01 13:13:43 corsair Exp $

DESCRIPTION="Determines where a given nameserver gets its information from"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
HOMEPAGE="http://www.mavetju.org/unix/general.php"

IUSE="ipv6"
KEYWORDS="x86 ~ppc ~sparc s390"
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

