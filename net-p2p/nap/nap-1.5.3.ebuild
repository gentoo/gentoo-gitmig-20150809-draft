# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nap/nap-1.5.3.ebuild,v 1.5 2004/10/04 21:59:25 pvdabeel Exp $

IUSE=""
DESCRIPTION="Console Napster/OpenNap client"
HOMEPAGE="http://quasar.mathstat.uottawa.ca/~selinger/nap/"
SRC_URI="http://quasar.mathstat.uottawa.ca/~selinger/nap/dist/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="as-is"

RDEPEND="virtual/libc"

src_compile() {
	./configure --prefix=${D}/usr || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake install || die "install problem"

	dodoc AUTHORS COPYRIGHT COPYING ChangeLog NEWS README
}
