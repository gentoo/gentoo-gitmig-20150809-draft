# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.22.20021129.ebuild,v 1.3 2002/12/14 01:25:36 lostlogic Exp $

IUSE="nas avi sdl kde oggvorbis 3dnow qt"

inherit libtool

MY_P=${P/.200/-200}
MY_S=${PN}0.7-0.7.22
S=${WORKDIR}/${MY_S}

DESCRIPTION="Library for AVI-Files"
SRC_URI="http://avifile.sourceforge.net/${MY_P}.tgz"
HOMEPAGE="http://avifile.sourceforge.net/"

# media-libs/xvid is still marked unstable.  This will be added to the
# list of deps soon! (hopefully) - raker 12/12/2002
DEPEND=">=media-libs/divx4linux-20020418
	media-libs/jpeg
	media-libs/win32codecs
	qt? ( >=x11-libs/qt-3.0.3 )
	nas? ( >=media-libs/nas-1.4.2 )
	sdl? ( >=media-libs/libsdl-1.2.2 )
	oggvorbis? ( media-libs/libvorbis )"

SLOT="0.7"
LICENSE="GPL-2"
KEYWORDS="~x86"

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

        # Make sure we include freetype2 headers before freetype1 headers, else Xft2
        # borks, bug #11941.
        export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
        export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	# Fix qt detection
	cp configure configure.orig
	sed -e "s:extern \"C\" void exit(int);:/* extern \"C\" void exit(int); */:" \
		< configure.orig > configure

	econf \
		--enable-quiet \
		--disable-tsc \
		${myconf} || die
		
	make || die
}

src_install () {

	dodir /usr/lib /usr/bin
	use avi && dodir /usr/lib/win32

	einstall || die

	cd ${S}
	dodoc COPYING README
	cd doc
	dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
	dodoc VIDEO-PERFORMANCE WARNINGS
}
