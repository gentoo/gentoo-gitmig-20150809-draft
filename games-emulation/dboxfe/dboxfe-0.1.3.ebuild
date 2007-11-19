# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dboxfe/dboxfe-0.1.3.ebuild,v 1.2 2007/11/19 20:05:25 mr_bones_ Exp $

inherit qt4 games

DESCRIPTION="Creates and manages configuration files for DOSBox"
HOMEPAGE="http://chmaster.freeforge.net/dboxfe-project.htm"
SRC_URI="mirror://berlios/dboxfe/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="$(qt4_min_version 4.3)"
RDEPEND=">=games-emulation/dosbox-0.65
	${DEPEND}"

src_install() {
	dogamesbin bin/dboxfe || die "dogamesbin failed"
	dodoc TODO ChangeLog
	newicon res/default.png ${PN}.png
	make_desktop_entry dboxfe "DosBoxFE"
	prepgamesdirs
}
