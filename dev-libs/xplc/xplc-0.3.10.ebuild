# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xplc/xplc-0.3.10.ebuild,v 1.3 2004/12/07 03:18:25 kloeri Exp $

DESCRIPTION="cross platform lightweight components library for C++"
HOMEPAGE="http://xplc.sourceforge.net"
SRC_URI="mirror://sourceforge/xplc/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha"
IUSE=""

DEPEND="virtual/libc
	dev-util/pkgconfig"

S=${WORKDIR}/${P}

src_install() {
	make DESTDIR=${D} install || die
	dosym /usr/lib/pkgconfig/${P}.pc /usr/lib/pkgconfig/${PN}.pc
	dodoc LICENSE README NEWS CREDITS
}
