# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xxl/xxl-1.0.1.ebuild,v 1.1 2005/02/11 11:51:23 ka0ttic Exp $

DESCRIPTION="C/C++ library that provides exception handling and asset management"
HOMEPAGE="http://www.zork.org/xxl/"
SRC_URI="http://www.zork.org/software/${P}.tar.gz"

LICENSE="ZORK"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
