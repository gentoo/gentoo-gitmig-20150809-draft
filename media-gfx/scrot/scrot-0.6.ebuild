# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/scrot/scrot-0.6.ebuild,v 1.7 2003/03/25 05:20:11 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Screen Shooter"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86 ~alpha"

DEPEND=">=media-libs/imlib2-1.0.3
	>=media-libs/giblib-1.2.1"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc TODO README AUTHORS ChangeLog
}
