# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/scrot/scrot-0.6.ebuild,v 1.3 2002/07/23 05:18:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Screen Shooter"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86"

DEPEND=">=media-libs/imlib2-1.0.3
	>=media-libs/giblib-1.2.1"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	dobin src/scrot
	dodoc TODO README AUTHORS ChangeLog
}
