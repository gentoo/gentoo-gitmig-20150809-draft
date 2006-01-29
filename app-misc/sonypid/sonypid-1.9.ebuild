# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-1.9.ebuild,v 1.7 2006/01/29 16:22:24 hanno Exp $

DESCRIPTION="tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://www.popies.net/sonypi/"
SRC_URI="http://www.popies.net/sonypi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="|| ( x11-libs/libXtst virtual/x11 )"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin sonypid || die
	dodoc AUTHORS CHANGES
}
