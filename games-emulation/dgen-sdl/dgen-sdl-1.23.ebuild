# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dgen-sdl/dgen-sdl-1.23.ebuild,v 1.13 2009/10/20 00:51:19 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A Linux/SDL-Port of the famous DGen MegaDrive/Genesis-Emulator"
HOMEPAGE="http://tamentis.com/projects/dgen/"
SRC_URI="http://tamentis.com/projects/dgen/files/${P}.tar.gz"

LICENSE="dgen-sdl"
SLOT="0"
KEYWORDS="x86"
IUSE="X mmx opengl"

RDEPEND="media-libs/libsdl
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	X? ( x11-misc/imake )
	dev-lang/nasm"

PATCHES=(
	# gcc34.patch for bug #116113
	# gcc4.patch for bug #133203
	"${FILESDIR}/${P}-gcc34.patch"
	"${FILESDIR}/${P}-gcc4.patch"
)

src_configure() {
	egamesconf \
		$(use_with opengl) \
		$(use_with X x) \
		$(use_with mmx)
}

src_compile() {
	emake -C musa m68kops.h || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README sample.dgenrc
	prepgamesdirs
}
