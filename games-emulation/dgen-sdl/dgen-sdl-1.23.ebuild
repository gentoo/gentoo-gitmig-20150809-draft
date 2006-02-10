# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dgen-sdl/dgen-sdl-1.23.ebuild,v 1.10 2006/02/10 19:32:00 wolf31o2 Exp $

inherit eutils gnuconfig games

DESCRIPTION="A Linux/SDL-Port of the famous DGen MegaDrive/Genesis-Emulator"
HOMEPAGE="http://www.pknet.com/~joe/dgen-sdl.html"
SRC_URI="http://www.pknet.com/~joe/${P}.tar.gz"

LICENSE="dgen-sdl"
SLOT="0"
KEYWORDS="x86"
IUSE="X mmx opengl"

RDEPEND="media-libs/libsdl
	opengl? ( virtual/opengl )"
DEPEND="X? (
	|| (
		x11-misc/imake
		virtual/x11 ) )
	dev-lang/nasm"

src_unpack() {
	unpack ${A}
	cd "${S}/star"
	epatch "${FILESDIR}/${P}-gcc34.patch" # for bug #116113
}

src_compile() {
	gnuconfig_update

	egamesconf \
		$(use_with opengl) \
		$(use_with X x) \
		$(use_with mmx) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README sample.dgenrc
	prepgamesdirs
}
