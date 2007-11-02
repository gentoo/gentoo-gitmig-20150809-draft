# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/amphetamine/amphetamine-0.8.10.ebuild,v 1.5 2007/11/02 21:57:14 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="a cool Jump'n Run game offering some unique visual effects"
HOMEPAGE="http://n.ethz.ch/student/loehrerl/amph/amph.html"
SRC_URI="http://n.ethz.ch/student/loehrerl/amph/files/${P}.tar.bz2
	http://n.ethz.ch/student/loehrerl/amph/files/${PN}-data-0.8.6.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl
	x11-libs/libXpm"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-64bit.patch
	sed -i \
		-e "/^INSTALL_DIR /s:=.*:= ${GAMES_DATADIR}/${PN}:" \
		-e "/^CFLAGS /s:$: ${CFLAGS}:" \
		-e "/^CXXFLAGS /s:-O9.*:${CXXFLAGS}:" \
		-e "/^DEPENDFLAGS /s:-g ::" \
		-e "/^LINKER /s:$: ${LDFLAGS}:" \
		-e "s:gcc:$(tc-getCC):" \
		-e "s:g++:$(tc-getCXX):" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	newgamesbin amph ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../amph/* || die "doins failed"
	newicon amph.xpm ${PN}.xpm
	make_desktop_entry ${PN} Amphetamine ${PN}
	dodoc BUGS ChangeLog NEWS README
	prepgamesdirs
}
