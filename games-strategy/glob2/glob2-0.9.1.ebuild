# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.9.1.ebuild,v 1.1 2007/09/10 00:47:51 nyhm Exp $

inherit eutils games

DESCRIPTION="Real Time Strategy (RTS) game involving a brave army of globs"
HOMEPAGE="http://globulation2.org/"
SRC_URI="http://dl.sv.nongnu.org/releases/glob2/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	dev-libs/boost
	media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/sdl-image
	media-libs/libvorbis
	media-libs/speex"
DEPEND="${RDEPEND}
	dev-util/scons"

src_compile() {
	scons \
		CXXFLAGS="${CXXFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		INSTALLDIR="${GAMES_DATADIR}"/${PN} \
		|| die "scons failed again"
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns data maps scripts || die "doins failed"
	find "${D}/${GAMES_DATADIR}"/${PN} -name SConscript -exec rm -f {} \;
	doicon data/icons/glob2-icon-48x48.png
	domenu data/glob2.desktop
	dodoc AUTHORS README TODO
	prepgamesdirs
}
