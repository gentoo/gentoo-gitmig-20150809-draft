# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nap/nap-1.5.1.ebuild,v 1.3 2003/03/16 21:23:02 gerk Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Console Napster/OpenNap client"
HOMEPAGE="http://quasar.mathstat.uottawa.ca/~selinger/nap/"
SRC_URI="http://quasar.mathstat.uottawa.ca/~selinger/nap/${P}.tar.gz"
LICENSE="as-is"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"
SLOT="0"
KEYWORDS="~x86 ppc"

src_compile() {
	./configure --prefix=${D}/usr || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake install || die "install problem"

	dodoc AUTHORS COPYRIGHT COPYING ChangeLog NEWS README
}
