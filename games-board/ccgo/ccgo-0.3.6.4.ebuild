# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ccgo/ccgo-0.3.6.4.ebuild,v 1.1 2010/01/15 16:15:12 tupone Exp $

EAPI=2
inherit games

DESCRIPTION="An IGS client written in C++"
HOMEPAGE="http://ccdw.org/~cjj/prog/ccgo/"
SRC_URI="http://ccdw.org/~cjj/prog/ccgo/src/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/gconfmm-2.6
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
