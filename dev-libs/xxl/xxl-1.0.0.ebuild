# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xxl/xxl-1.0.0.ebuild,v 1.3 2004/06/24 23:39:01 agriffis Exp $

DESCRIPTION="C/C++ library that provides exception handling and asset management"
HOMEPAGE="http://www.zork.org/xxl/"
SRC_URI="http://www.zork.org/software/${P}.tar.gz"

LICENSE="ZORK"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_install() {
	emake install DESTDIR=${D} || die
	dodoc README
}
