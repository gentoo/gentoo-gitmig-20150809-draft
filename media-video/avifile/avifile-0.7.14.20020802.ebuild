# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.14.20020802.ebuild,v 1.5 2002/08/27 20:38:19 raker Exp $

inherit libtool

MY_P=${P/.200/-200}
MY_S=${PN}0.7-0.7.14
S=${WORKDIR}/${MY_S}

DESCRIPTION="Library for AVI-Files"
SRC_URI="http://avifile.sourceforge.net/${MY_P}.tgz"
HOMEPAGE="http://avifile.sourceforge.net/"

DEPEND=">=media-libs/divx4linux-20020418
	media-libs/jpeg
	media-libs/win32codecs
	qt? ( >=x11-libs/qt-3.0.3 )
	nas? ( >=media-libs/nas-1.4.2 )
	sdl? ( >=media-libs/libsdl-1.2.2 )
	oggvorbis? ( media-libs/libvorbis )"

SLOT="0.7"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	elibtoolize

	local myconf=""
	local kdepre=""
	
	( use mmx || use sse || use 3dnow ) && myconf="${myconf} --enable-x86opt"

	use qt \
		&& myconf="${myconf} --with-qt-dir=${QTDIR}" \
		|| myconf="${myconf} --without-qt"
	
	use sdl \
		&& myconf="${myconf} --enable-sdl" \
		|| myconf="${myconf} --disable-sdl --disable-sdltest"
	
	use nas && LDFLAGS="-L/usr/X11R6/lib -lXt"

	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis --disable-oggtest --disable-vorbistest"
	
	if [ `use kde` ]
	then
		myconf="${myconf} --enable-kde --with-extra-libraries=${KDEDIR}"
		LDFLAGS="${LDFLAGS} -L${KDEDIR}/lib"
	else
		myconf="${myconf} --disable-kde"
		LDFLAGS="${LDFLAGS}"
	fi

	# Rather not use custom ones here .. build should set as high as
	# safe by itself.
	unset CFLAGS CXXFLAGS LDFLAGS
	
	econf \
		--enable-quiet \
		--disable-tsc \
		${myconf} || die
		
	make || die
}

src_install () {

	dodir /usr/lib /usr/bin
	use avi && dodir /usr/lib/win32

	make prefix=${D}/usr datadir=${S}/usr/share install || die

	cd ${S}
	dodoc COPYING README
	cd doc
	dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
	dodoc VIDEO-PERFORMANCE WARNINGS
}
