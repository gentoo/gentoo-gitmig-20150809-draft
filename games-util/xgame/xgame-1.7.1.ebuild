# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xgame/xgame-1.7.1.ebuild,v 1.3 2004/12/07 09:09:21 mr_bones_ Exp $

inherit games

DESCRIPTION="Run games in a separate X session"
HOMEPAGE="http://xgame.tlhiv.com/"
SRC_URI="http://downloads.tlhiv.com/xgame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/perl"

src_install() {
	dogamesbin xgame || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}
