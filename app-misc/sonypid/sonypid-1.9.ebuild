# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-1.9.ebuild,v 1.5 2004/06/28 04:14:09 vapier Exp $

DESCRIPTION="tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://spop.free.fr/sonypi/"
SRC_URI="http://spop.free.fr/sonypi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin sonypid || die
	dodoc AUTHORS CHANGES
}
