# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/xe/xe-20050801.ebuild,v 1.1 2005/08/04 21:33:06 mr_bones_ Exp $

inherit games

MY_PV="${PV:2:2}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="a multi system emulator for many console and handheld video game systems"
HOMEPAGE="http://www.xe-emulator.com/"
SRC_URI="http://www.xe-emulator.com/files/${PN}-${MY_PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
RESTRICT="nostrip"

RDEPEND="virtual/x11
	sys-libs/zlib
	=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-bin

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/strip/d' \
		-e '/^CC/d' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	newgamesbin xe xe.bin || die "newgamesbin failed"
	newgamesbin "${FILESDIR}/xe-${PV}" xe || die "newgamesbin failed"
	sed -i \
		-e "s:GENTOODIR:${GAMES_LIBDIR}/${PN}:" "${D}/${GAMES_BINDIR}/xe" \
		|| die "sed failed"
	insinto "${GAMES_LIBDIR}/${PN}"
	doins -r modules || die "doins failed"
	dodoc README.txt
	prepgamesdirs
}
