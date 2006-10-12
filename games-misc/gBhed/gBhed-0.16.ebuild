# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/gBhed/gBhed-0.16.ebuild,v 1.5 2006/10/12 00:03:14 nyhm Exp $

inherit games

DESCRIPTION="An Al Bhed translator"
HOMEPAGE="http://liquidchile.net/software/gbhed/"
SRC_URI="http://liquidchile.net/software/gbhed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk"

DEPEND="gtk? (
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2 )"

src_compile() {
	egamesconf $(use_enable gtk gbhed) || die
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
