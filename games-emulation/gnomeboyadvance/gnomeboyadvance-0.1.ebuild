# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnomeboyadvance/gnomeboyadvance-0.1.ebuild,v 1.13 2010/10/13 16:39:38 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit python games

DESCRIPTION="A GNOME Python frontend to VisualBoyAdvance"
HOMEPAGE="http://developer.berlios.de/projects/gnomeboyadvance/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND=">=dev-python/gnome-python-1.99
	 >=dev-python/pygtk-1.99
	 games-emulation/visualboyadvance"

S=${WORKDIR}/gnomeBoyAdvance-0.1

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	sed -i \
		-e 's:/usr/share/:/usr/share/games/:' \
			gnomeboyadvance \
			|| die "sed gnomeboyadvance failed"
	python_convert_shebangs -r 2 ${PN}
}

src_install() {
	dogamesbin gnomeboyadvance || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/gnomeboyadvance
	doins gnomeBoyAdvance.png gnomeboyadvance.glade || die "doins failed"
	dodoc README CHANGES TODO
	prepgamesdirs
}
