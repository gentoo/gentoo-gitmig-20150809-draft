# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/powershell/powershell-0.8.ebuild,v 1.8 2003/09/07 00:24:01 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Terminal emulator, supports multiple terminals in a single window"
SRC_URI="http://powershell.pdq.net/download/${P}.tar.gz"
HOMEPAGE="http://powershell.pdq.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc
	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc AUTHORS BUGS COPYING README
}
