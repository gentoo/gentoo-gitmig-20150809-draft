# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Maik Schreiber <bZ@iq-computing.de>
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nap/nap-1.5.0.ebuild,v 1.1 2002/06/25 10:26:11 bangert Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Console Napster/OpenNap client"
HOMEPAGE="http://quasar.mathstat.uottawa.ca/~selinger/nap/"
RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"
SRC_URI="http://quasar.mathstat.uottawa.ca/~selinger/nap/${P}.tar.gz"

src_compile() {
	./configure --prefix=${D}/usr || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake install || die "install problem"

	dodoc AUTHORS COPYRIGHT COPYING ChangeLog NEWS README
}
