# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dxr3player/dxr3player-0.10.9.ebuild,v 1.1 2007/03/21 18:10:22 drac Exp $

DESCRIPTION="DVD player for RealMagic Hollywood+/Creative DXR3 MPEG-2 decoders"
HOMEPAGE="http://dxr3player.sourceforge.net/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="3dnow 3dnowext lirc mad mmx mmxext sdl sse"

RDEPEND="media-libs/libpng
	media-libs/freetype
	media-libs/libmpeg2
	>=media-libs/libmad-0.15.1b
	>=media-video/em8300-libraries-0.15.3
	mad? ( >=media-libs/libmad-0.15.1b )
	sdl? ( media-libs/libsdl )
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}"

src_compile() {
	if use lirc; then
		myconf="--with-lirc=/usr"
	fi

	if use sdl; then
		myconf="${myconf} --with-sdl=/usr"
	fi

	econf --enable-overlay --enable-joystick \
		--with-em8300=/usr --with-libpng \
		--enable-dump-playback \
		$(use_with mad) \
		$(use_with mmx mm-accel mmx) \
		$(use_with mmxext mm-accel mmxext) \
		$(use_with sse mm-accel sse) \
		$(use_with 3dnow mm-accel 3dnow) \
		$(use_with 3dnowext mm-accel 3dnowext) \
		${myconf}

	emake || die "emake install failed."
}

src_install() {
	dodoc AUTHORS ChangeLog NEWS README TODO

	dobin src/dxr3player/dxr3player src/dxr3player/dumpdvd
	use sdl && dobin src/dxr3player/dxr3player-sdl
}
