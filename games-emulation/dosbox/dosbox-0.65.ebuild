# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.65.ebuild,v 1.2 2006/08/27 23:54:07 weeve Exp $

inherit games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="alsa hardened opengl"

DEPEND="sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl )
	media-libs/libpng
	>=media-libs/libsdl-1.2.0
	media-libs/sdl-net
	media-libs/sdl-sound"

src_compile() {
	local myconf=

	if ! use alsa ; then
		myconf="--without-alsa-prefix --without-alsa-inc-prefix --disable-alsatest"
	fi
	# bug #66038
	if use hardened ; then
		myconf="${myconf} --disable-dynamic-x86"
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
	dodoc AUTHORS ChangeLog NEWS README THANKS
	prepgamesdirs
}
