# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gozer/gozer-0.7.ebuild,v 1.2 2002/07/23 04:33:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="tool for rendering arbitary text as graphics, using ttfs and styles"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	>=media-libs/giblib-1.2.1"

src_compile() {

	econf || die
	emake || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man install || die

	dodoc TODO README AUTHORS ChangeLog
}
