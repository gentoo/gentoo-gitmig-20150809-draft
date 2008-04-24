# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.7.2.ebuild,v 1.2 2008/04/24 15:01:34 flameeyes Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/libpng
	dev-libs/boost"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.97"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-paths.patch
	epatch "${FILESDIR}/${P}+gcc-4.3.patch"
	sed -i \
		-e "s:GENTOO_BINDIR:${GAMES_BINDIR}:" \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		install.sh src/pingus_main.cpp \
		|| die "sed failed"
}

src_compile() {
	scons configure \
		CXX="$(tc-getCXX)" \
		CCFLAGS="${CXXFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		|| die "scons configure failed"
	scons || die "scons failed"
}

src_install() {
	./install.sh "${D}" || die "install.sh failed"
	newicon data/images/pingus/player0/boarder.png ${PN}.png
	make_desktop_entry ${PN} Pingus
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
