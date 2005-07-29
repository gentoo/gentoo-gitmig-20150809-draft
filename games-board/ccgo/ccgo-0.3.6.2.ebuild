# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ccgo/ccgo-0.3.6.2.ebuild,v 1.2 2005/07/29 10:41:38 dholm Exp $

inherit games

DESCRIPTION="An IGS client written in C++ "
HOMEPAGE="http://ccdw.org/~cjj/prog/ccgo/"
SRC_URI="http://ccdw.org/~cjj/prog/ccgo/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nls"

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/gconfmm-2.6
	nls? ( sys-devel/gettext )"

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
