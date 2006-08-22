# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/lpairs/lpairs-1.0.1.ebuild,v 1.10 2006/08/22 08:21:20 mr_bones_ Exp $

inherit games

DESCRIPTION="A classical memory game"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LPairs"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS TODO ChangeLog
	prepgamesdirs
}
