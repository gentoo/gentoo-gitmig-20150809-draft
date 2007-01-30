# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/avp/avp-20070130.ebuild,v 1.1 2007/01/30 22:41:43 nyhm Exp $

inherit games

DESCRIPTION="Linux port of Aliens vs Predator"
HOMEPAGE="http://www.icculus.org/avp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="AvP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/openal
	media-libs/libsdl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS/s/-g.*/${CFLAGS}/" \
		-e "/^LDLIBS/s/$/${LDFLAGS}/" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	newgamesbin AvP.bin AvP || die "newgamesbin failed"
	dodoc README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "please follow the instructions in"
	elog "/usr/share/doc/${PF}/README.gz"
	elog "to install the rest of the game"
}
