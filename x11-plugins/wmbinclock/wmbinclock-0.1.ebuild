# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbinclock/wmbinclock-0.1.ebuild,v 1.7 2004/06/24 23:05:35 agriffis Exp $

IUSE=""

S="${WORKDIR}/wmBinClock"
HOMEPAGE="http://www.inxsoft.net/wmbinclock"
DESCRIPTION="wmbinclock shows the actual system time as a binary clock"
SRC_URI="http://www.inxsoft.net/wmbinclock/${P}.tar.gz"

SLOT="0"
LICENSE="freedist"
KEYWORDS="~x86 amd64 ppc"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {
	myconf=""
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc README
	dodir /usr/bin
	make DESTDIR=${D}/usr install || die
}
