# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.61.ebuild,v 1.5 2004/03/05 19:41:29 mr_bones_ Exp $

inherit games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

KEYWORDS="x86 amd64 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="alsa opengl"

DEPEND="virtual/glibc
	alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2.0
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-net"

src_compile() {
	local myconf=""

	if ! use alsa ; then
		myconf="--without-alsa-prefix --without-alsa-inc-prefix --disable-alsatest"
	fi
	egamesconf \
		--disable-dependency-tracking \
		${myconf} \
		`use_enable opengl` \
			|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	prepgamesdirs
}
