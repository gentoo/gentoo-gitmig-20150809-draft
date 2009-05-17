# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/snipes/snipes-1.0.4.ebuild,v 1.2 2009/05/17 17:25:52 nixnut Exp $

inherit eutils games

DESCRIPTION="2D scrolling shooter, resembles the old DOS game of same name"
HOMEPAGE="http://cyp.github.com/snipes/"
SRC_URI="http://cyp.github.com/snipes/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	dogamesbin snipes || die "dogamesbin failed"
	doman snipes.6
	dodoc ChangeLog
	doicon ${PN}.png
	make_desktop_entry snipes "Snipes"
	prepgamesdirs
}
