# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ferrisloki/ferrisloki-2.0.5.ebuild,v 1.1 2004/08/15 04:56:09 vapier Exp $

DESCRIPTION="Loki C++ library from Modern C++ Design"
HOMEPAGE="http://witme.sourceforge.net/libferris.web/"
SRC_URI="mirror://sourceforge/witme/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-libs/STLport-4.5.3-r3
	=dev-libs/libsigc++-1.2*"

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
