# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/ivan/ivan-0.50.ebuild,v 1.3 2006/01/05 05:38:33 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="Rogue-like game with SDL graphics"
HOMEPAGE="http://ivan.sourceforge.net/"
SRC_URI="mirror://sourceforge/ivan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.0"

src_compile() {
	replace-flags -O? -O0 #bug #113627
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog LICENSING NEWS README
	keepdir "${GAMES_STATEDIR}/ivan/Bones"
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/ivan/Bones"
}
