# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/remind/remind-03.00.22.ebuild,v 1.4 2004/06/24 22:31:35 agriffis Exp $

DESCRIPTION="Ridiculously functional reminder program"
HOMEPAGE="http://www.roaringpenguin.com/products/remind/"
SRC_URI="http://www.roaringpenguin.com/products/remind/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

src_install() {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/share/man/man1
	einstall || die
}
