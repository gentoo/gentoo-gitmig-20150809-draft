# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancescan/advancescan-1.13.ebuild,v 1.1 2005/03/25 07:26:30 mr_bones_ Exp $

inherit games

DESCRIPTION="A command line rom manager for MAME, MESS, AdvanceMAME, AdvanceMESS and Raine"
HOMEPAGE="http://advancemame.sourceforge.net/scan-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_install() {
	dogamesbin advscan advdiff || die "dogamesbin failed"
	dodoc AUTHORS HISTORY README doc/*.txt advscan.rc.linux
	doman doc/*.1
	dohtml doc/*.html
	prepgamesdirs
}
