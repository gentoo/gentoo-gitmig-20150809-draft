# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gozer/gozer-0.7-r1.ebuild,v 1.9 2009/11/25 22:19:57 maekke Exp $

DESCRIPTION="tool for rendering arbitrary text as graphics, using ttfs and styles"
HOMEPAGE="http://www.linuxbrit.co.uk/gozer/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/libXext
	>=media-libs/giblib-1.2.1"

src_install() {
	make install DESTDIR=${D} || die
	rm -rf ${D}/usr/doc
	dodoc TODO README AUTHORS ChangeLog
}
