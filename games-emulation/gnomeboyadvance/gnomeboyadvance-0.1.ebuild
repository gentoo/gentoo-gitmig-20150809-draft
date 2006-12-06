# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnomeboyadvance/gnomeboyadvance-0.1.ebuild,v 1.9 2006/12/06 17:16:27 wolf31o2 Exp $

inherit games


DESCRIPTION="A GNOME Python frontend to VisualBoyAdvance"
HOMEPAGE="http://developer.berlios.de/projects/gnomeboyadvance/"
SRC_URI="http://download.berlios.de/gnomeboyadvance/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=dev-lang/python-2.2
	 >=dev-python/gnome-python-1.99
	 >=dev-python/pygtk-1.99
	 games-emulation/visualboyadvance"

S=${WORKDIR}/gnomeBoyAdvance-0.1

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's:/usr/share/:/usr/share/games/:' \
			gnomeboyadvance \
			|| die "sed gnomeboyadvance failed"
}

src_install() {
	dogamesbin gnomeboyadvance || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/gnomeboyadvance
	doins gnomeBoyAdvance.png gnomeboyadvance.glade || die "doins failed"
	dodoc README CHANGES TODO
	prepgamesdirs
}
