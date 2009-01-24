# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnugo/gnugo-3.7.13.ebuild,v 1.1 2009/01/24 05:22:49 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="A Go-playing program"
HOMEPAGE="http://www.gnu.org/software/gnugo/devel.html"
SRC_URI="http://match.stanford.edu/gnugo/archive/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="readline"

DEPEND=">=sys-libs/ncurses-5.2-r3
	readline? ( sys-libs/readline )"

src_configure() {
	egamesconf \
		$(use_with readline) \
		--disable-dependency-tracking \
		--enable-cache-size=32 || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
