# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dxr3player/dxr3player-0.9.4.ebuild,v 1.2 2005/03/21 15:53:13 luckyduck Exp $

DESCRIPTION="A DVD player for Linux, supports the DXR3 (aka Hollywood+) board."
HOMEPAGE="http://dxr3player.sourceforge.net/"

SRC_URI="http://dxr3player.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="lirc sdl mmx sse 3dnow"

DEPEND=">=media-libs/libmad-0.15.1b
	lirc? ( app-misc/lirc )
	sdl? ( media-libs/libsdl )
	media-libs/libmpeg2"

src_compile() {

	myconf="--with-mad"

	if use lirc; then
		myconf="${myconf} --with-lirc=/usr"
	fi

	if use sdl; then
		myconf="${myconf} --with-sdl=/usr"
	fi

	if [ -e /usr/include/linux/em8300.h ]
	then
		myconf="${myconf} --with-em8300=/usr"
	fi

	if use 3dnow; then
		accel=" --with-mm-accel=3dnow"
	fi
	if use mmx; then
		accel=" --with-mm-accel=mmx"
	fi
	if use sse; then
		accel=" --with-mm-accel=sse"
	fi

	econf ${myconf} ${accel} || die
	emake || die
}

src_install() {
	dodoc AUTHORS COPYING ChangeLog INSTALL INSTALL.fr LISEZMOI NEWS README

	mybin="src/dxr3player/dumpdvd"

	if [ -e /usr/include/linux/em8300.h ]
	then
		mybin="${mybin} src/dxr3player/dxr3player"
	fi

	if use sdl; then
		mybin="${mybin} src/dxr3player/dxr3player-sdl"
	fi

	dobin $mybin
}
