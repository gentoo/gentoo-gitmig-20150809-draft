# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gozer/gozer-0.7-r1.ebuild,v 1.1 2004/07/14 02:31:00 vapier Exp $

DESCRIPTION="tool for rendering arbitary text as graphics, using ttfs and styles"
HOMEPAGE="http://www.linuxbrit.co.uk/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11
	>=media-libs/giblib-1.2.1"

src_install() {
	make install DESTDIR=${D} || die
	rm -rf ${D}/usr/doc
	dodoc TODO README AUTHORS ChangeLog
}
