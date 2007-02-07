# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnomeboyadvance/gnomeboyadvance-0.1.ebuild,v 1.11 2007/02/07 13:56:41 nyhm Exp $

inherit games

DESCRIPTION="A GNOME Python frontend to VisualBoyAdvance"
HOMEPAGE="http://developer.berlios.de/projects/gnomeboyadvance/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

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
