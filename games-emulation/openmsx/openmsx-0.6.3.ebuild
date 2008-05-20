# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/openmsx/openmsx-0.6.3.ebuild,v 1.3 2008/05/20 16:26:08 fmccor Exp $

inherit toolchain-funcs games

DESCRIPTION="MSX emulator that aims for perfection"
HOMEPAGE="http://openmsx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="jack"

DEPEND="dev-lang/tcl
	dev-libs/libxml2
	media-libs/libpng
	media-libs/libsdl
	media-libs/glew
	media-libs/sdl-image
	virtual/opengl
	jack? ( media-sound/jack-audio-connection-kit )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/LINK_FLAGS+=/s/-s//' build/main.mk || die "sed failed"
	sed -i \
		-e "/DISABLED/s:$:$(use jack || echo JACK):" \
		-e '/SYMLINK/s:true:false:' \
		build/custom.mk \
		|| die "sed custom.mk failed"
}

src_compile() {
	egamesconf || die
	emake \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}" \
		INSTALL_SHARE_DIR="${GAMES_DATADIR}"/${PN} \
		|| die "emake failed"
}

src_install() {
	emake \
		INSTALL_BINARY_DIR="${D}${GAMES_BINDIR}" \
		INSTALL_SHARE_DIR="${D}${GAMES_DATADIR}"/${PN} \
		INSTALL_DOC_DIR="${D}"/usr/share/doc/${PF} \
		install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
