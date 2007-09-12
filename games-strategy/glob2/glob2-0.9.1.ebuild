# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.9.1.ebuild,v 1.4 2007/09/12 21:15:12 nyhm Exp $

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
	>=dev-util/scons-0.97"

pkg_setup() {
	games_pkg_setup
	if has_version "<dev-libs/boost-1.34" && \
		! built_with_use dev-libs/boost threads
	then
		die "Please emerge dev-libs/boost with USE=threads"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '1i SConsignFile()' SConstruct || die "sed failed"
}

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
