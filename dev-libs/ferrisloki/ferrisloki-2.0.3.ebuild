# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ferrisloki/ferrisloki-2.0.3.ebuild,v 1.2 2004/06/24 23:09:50 agriffis Exp $

DESCRIPTION="Loki C++ library from Modern C++ Design"
HOMEPAGE="http://witme.sourceforge.net/libferris.web/"
SRC_URI="mirror://sourceforge/witme/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-libs/STLport
	>=dev-libs/libsigc++-1.2"

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
