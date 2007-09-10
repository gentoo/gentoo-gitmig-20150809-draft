# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/avp/avp-20070130-r1.ebuild,v 1.2 2007/09/10 19:37:43 tupone Exp $

inherit eutils games

DESCRIPTION="Linux port of Aliens vs Predator"
HOMEPAGE="http://www.icculus.org/avp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="AvP"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x86? (
		media-libs/openal
		media-libs/libsdl
	)
	amd64? ( app-emulation/emul-linux-x86-sdl )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc42.patch
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
