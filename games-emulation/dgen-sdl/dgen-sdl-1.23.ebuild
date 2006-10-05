# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dgen-sdl/dgen-sdl-1.23.ebuild,v 1.12 2006/10/05 04:56:02 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A Linux/SDL-Port of the famous DGen MegaDrive/Genesis-Emulator"
HOMEPAGE="http://www.pknet.com/~joe/dgen-sdl.html"
SRC_URI="http://www.pknet.com/~joe/${P}.tar.gz"

LICENSE="dgen-sdl"
SLOT="0"
KEYWORDS="x86"
IUSE="X mmx opengl"

RDEPEND="media-libs/libsdl
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	X? ( x11-misc/imake )
	dev-lang/nasm"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# gcc34.patch for bug #116113
	# gcc4.patch for bug #133203
	epatch \
		"${FILESDIR}/${P}-gcc34.patch" \
		"${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	egamesconf \
		$(use_with opengl) \
		$(use_with X x) \
		$(use_with mmx) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README sample.dgenrc
	prepgamesdirs
}
