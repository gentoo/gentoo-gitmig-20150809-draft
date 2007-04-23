# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xsfcave/xsfcave-0.5.ebuild,v 1.2 2007/04/23 02:03:57 mr_bones_ Exp $

inherit games

DESCRIPTION="A X11 sfcave clone"
HOMEPAGE="http://xsfcave.idios.org"
SRC_URI="mirror://sourceforge/scrap/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/libXext
	x11-libs/libSM"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog THANKS TODO
	prepgamesdirs
}
