# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/powershell/powershell-0.8.ebuild,v 1.12 2004/07/15 01:01:47 agriffis Exp $

DESCRIPTION="Terminal emulator, supports multiple terminals in a single window"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://powershell.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

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
