# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dgen-sdl/dgen-sdl-1.23.ebuild,v 1.1 2003/09/09 16:26:49 vapier Exp $

DESCRIPTION="DGen/SDL is a Linux/SDL-Port of the famous DGen MegaDrive/Genesis-Emulator"
HOMEPAGE="http://www.pknet.com/~joe/dgen-sdl.html"
SRC_URI="http://www.pknet.com/~joe/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86"
LICENSE="dgen-sdl"
IUSE="X mmx opengl"

DEPEND="media-libs/libsdl X? virtual/x11 opengl? virtual/opengl"
RDEPEND="${DEPEND} dev-lang/nasm"

src_compile() {
	local myconf=""
	use opengl || myconf="${myconf} --without-opengl"
	use X && myconf="${myconf} --with-x"
	use mmx || myconf="${myconf} --without-mmx"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
