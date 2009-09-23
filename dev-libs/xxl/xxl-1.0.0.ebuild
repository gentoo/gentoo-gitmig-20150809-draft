# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xxl/xxl-1.0.0.ebuild,v 1.7 2009/09/23 16:52:28 patrick Exp $

DESCRIPTION="C/C++ library that provides exception handling and asset management"
HOMEPAGE="http://www.zork.org/xxl/"
SRC_URI="http://www.zork.org/software/${P}.tar.gz"

LICENSE="ZORK"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
