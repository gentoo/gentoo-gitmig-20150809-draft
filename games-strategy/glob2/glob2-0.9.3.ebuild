# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.9.3.ebuild,v 1.7 2008/05/22 18:41:51 maekke Exp $

inherit eutils games

DESCRIPTION="Real Time Strategy (RTS) game involving a brave army of globs"
HOMEPAGE="http://globulation2.org/"
SRC_URI="http://dl.sv.nongnu.org/releases/glob2/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	>=dev-libs/boost-1.34
	media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/sdl-image
	media-libs/libvorbis
	media-libs/speex"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.97"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	scons \
		CXXFLAGS="${CXXFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		INSTALLDIR="${GAMES_DATADIR}"/${PN} \
		DATADIR="${GAMES_DATADIR}"/${PN} \
		|| die "scons failed again"
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r AUTHORS campaigns data maps scripts || die "doins failed"
	find "${D}/${GAMES_DATADIR}"/${PN} -name SConscript -exec rm -f {} \;
	newicon data/icons/glob2-icon-48x48.png ${PN}.png
	make_desktop_entry glob2 "Globulation 2"
	dodoc AUTHORS README*
	prepgamesdirs
}
