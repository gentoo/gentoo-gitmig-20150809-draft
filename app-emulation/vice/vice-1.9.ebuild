# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.9.ebuild,v 1.1 2002/08/03 21:38:49 aliz Exp $

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://viceteam.bei.t-online.de/"
SRC_URI="ftp://ftp.funet.fi/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-base/xfree-4.0
	sdl? ( media-libs/libsdl )
	gnome? ( gnome-base/gnome )"

#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	local myconf="--enable-fullscreen"
	use sdl && myconf="${myconf} --with-sdl"
	use gnome && myconf="${myconf} --enable-gnomeui"
	use nls || myconf="${myconf} --disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man ${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dohtml ${D}/usr/lib/vice/doc/*.html
	dodoc \
		${D}/usr/lib/vice/doc/NLS-Howto.txt \
		${D}/usr/lib/vice/doc/Readme.beos \
		${D}/usr/lib/vice/doc/Readme.dos \
		${D}/usr/lib/vice/doc/Win32-Howto.txt \
		${D}/usr/lib/vice/doc/mon.txt

	rm ${D}/usr/lib/vice/doc -rf
}
