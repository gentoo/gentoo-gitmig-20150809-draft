# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/matritsa/matritsa-0.1.2.ebuild,v 1.9 2006/03/12 23:41:35 mr_bones_ Exp $

inherit games

DESCRIPTION="Kids card/puzzle game"
HOMEPAGE="http://imagic.weizmann.ac.il/~dov/freesw/matritsa.html"
SRC_URI="http://imagic.weizmann.ac.il/~dov/freesw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*"

src_install() {
	egamesinstall || die
	dodoc README AUTHORS TODO ChangeLog
	prepgamesdirs
}
