# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/transcalc/transcalc-0.14.ebuild,v 1.2 2004/06/24 22:19:37 agriffis Exp $

DESCRIPTION="A microwave and RF transmission line calculator"
HOMEPAGE="http://transcalc.sourceforge.net"
SRC_URI="http://transcalc.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING README TODO
}
