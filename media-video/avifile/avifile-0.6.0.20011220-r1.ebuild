# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author:  Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.6.0.20011220-r1.ebuild,v 1.3 2002/04/30 09:49:50 seemant Exp $

MY_P=${P/.200/-200}
MY_S=${MY_P/avifile-/avifile}
MY_S=${MY_S/.0-200/-200}
S=${WORKDIR}/${MY_S}
DESCRIPTION="Library for AVI-Files"
SRC_URI="http://avifile.sourceforge.net/${MY_P}admin.tgz"
HOMEPAGE="http://divx.euro.ru/"

DEPEND="=media-libs/divx4linux-20011025*
	media-libs/jpeg
	media-libs/win32codecs
	sdl? ( >=media-libs/libsdl-1.2.2 )
	qt? ( =x11-libs/qt-2* )
	nas? ( >=media-libs/nas-1.4.2 )
	oggvorbis? ( media-libs/libvorbis )"

SLOT="0.6"

src_compile() {

	local myconf
	
	use mmx && myconf="--enable-x86opt"
	use sse && myconf="--enable-x86opt"
	use 3dnow && myconf="--enable-x86opt"

	use qt \
		&& myconf="${myconf} --with-qt-dir=/usr/qt/2" \
		|| myconf="${myconf} --disable-qt"
	
	use kde \
		&& myconf="${myconf} --enable-kde" \
		|| myconf="${myconf} --disable-kde"
	
	use sdl \
		&& myconf="${myconf} --enable-sdl" \
		|| myconf="${myconf} --disable-sdl --disable-sdltest"
	
	use nas && LDFLAGS="-L/usr/X11R6/lib -lXt"

	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis --disable-oggtest --disable-vorbistest"

	export CFLAGS=${CFLAGS/-O?/-O2}
	LDFLAGS="$LDFLAGS -L/usr/kde/2/lib"
	export LDFLAGS
	./configure --prefix=/usr \
		--host=${CHOST} \
		--enable-quiet \
		--disable-tsc \
		--with-extra-libraries=/usr/kde/2 \
		${myconf} || die
		
#	cp Makefile Makefile.orig
#	sed -e "s:/usr/lib/win32:${D}/usr/lib/win32:" \
#		Makefile.orig > Makefile

	make || die
}

src_install () {

	dodir /usr/lib /usr/bin
	use avi && dodir /usr/lib/win32

	make prefix=${D}/usr install || die

	cd ${S}
	dodoc COPYING README
	cd doc
	dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
	dodoc VIDEO-PERFORMANCE WARNINGS
}

