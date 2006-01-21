# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/remind/remind-03.00.22.ebuild,v 1.11 2006/01/21 12:12:14 nelchael Exp $

DESCRIPTION="Ridiculously functional reminder program"
HOMEPAGE="http://www.roaringpenguin.com/products/remind/"
SRC_URI="http://www.roaringpenguin.com/products/remind/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="X"

RDEPEND="X? ( dev-lang/tk )"

src_install() {
	dodir /usr/bin /usr/share/man/man1
	einstall || die
}
