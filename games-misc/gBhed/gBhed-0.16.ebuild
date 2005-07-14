# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/gBhed/gBhed-0.16.ebuild,v 1.2 2005/07/14 08:45:09 dholm Exp $

inherit games

DESCRIPTION="An Al Bhed translator"
HOMEPAGE="http://liquidchile.net/software/gbhed/"
SRC_URI="http://liquidchile.net/software/gbhed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk"

DEPEND="gtk? ( >=x11-libs/gtk+-2.2* >=dev-libs/glib-2.2* )"

src_compile() {
	egamesconf $(use_enable gtk gbhed) || die
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
