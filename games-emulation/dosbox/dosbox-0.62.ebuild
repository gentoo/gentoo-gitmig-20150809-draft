# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.62.ebuild,v 1.2 2004/10/04 01:03:15 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

KEYWORDS="x86 ~amd64 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="alsa opengl"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl )
	media-libs/libpng
	sys-libs/zlib
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-net-1
	media-libs/sdl-sound"

src_unpack() {
	unpack ${A}
	sed -i \
		-e 's/: install-docDATA/:/' "${S}/Makefile.in" \
		|| die "sed failed"
}

src_compile() {
	local myconf=

	if ! use alsa ; then
		myconf="--without-alsa-prefix --without-alsa-inc-prefix --disable-alsatest"
	fi
	egamesconf \
		--disable-dependency-tracking \
		${myconf} \
		$(use_enable opengl) \
			|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	prepgamesdirs
}
