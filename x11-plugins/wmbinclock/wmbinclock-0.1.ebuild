# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbinclock/wmbinclock-0.1.ebuild,v 1.2 2003/06/12 22:26:36 msterret Exp $

IUSE=""

S="${WORKDIR}/wmBinClock"
HOMEPAGE="http://www.inxsoft.net/wmbinclock"
DESCRIPTION="wmbinclock shows the actual system time as a binary clock"
SRC_URI="http://www.inxsoft.net/wmbinclock/${P}.tar.gz"

SLOT="0"
LICENSE="freedist"
KEYWORDS="~x86"

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
