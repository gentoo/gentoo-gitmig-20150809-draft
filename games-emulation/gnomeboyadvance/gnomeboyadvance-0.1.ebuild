# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnomeboyadvance/gnomeboyadvance-0.1.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

S=${WORKDIR}/gnomeBoyAdvance-0.1

DESCRIPTION="A GNOME Python frontend to VisualBoyAdvance"
HOMEPAGE="http://www.socialistsoftware.com/gnomeboyadvance.php"
SRC_URI="http://www.socialistsoftware.com/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/python-2.2
	 >=dev-python/gnome-python-1.99
	 >=dev-python/pygtk-1.99
	 games-emulation/visualboyadvance"

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:/usr/share/:/usr/share/games/:' \
			gnomeboyadvance || die "sed gnomeboyadvance failed"
}

src_install() {
	dogamesbin gnomeboyadvance
	insinto ${GAMES_DATADIR}/gnomeboyadvance
	doins gnomeBoyAdvance.png gnomeboyadvance.glade
	dodoc README CHANGES TODO
	prepgamesdirs
}
