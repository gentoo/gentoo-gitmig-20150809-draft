# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xgame-gtk2/xgame-gtk2-2.0.2.ebuild,v 1.1 2005/01/04 15:03:54 citizen428 Exp $

inherit games

DESCRIPTION="Run games in a separate X session"
HOMEPAGE="http://xgame.tlhiv.com/"
SRC_URI="http://downloads.tlhiv.com/xgame/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-perl/gtk2-perl-1.040"

src_install() {
	dogamesbin xgame-gtk2 || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}

