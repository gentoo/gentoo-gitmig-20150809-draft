# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.27.20030122-r1.ebuild,v 1.7 2003/03/25 22:10:28 seemant Exp $

IUSE="static truetype xv sdl oss dvd mmx sse 3dnow zlib oggvorbis X qt"

inherit libtool eutils

MY_P="${P/.200/-200}"
MY_S="${PN}0.7-0.7.27"
S="${WORKDIR}/${MY_S}"

DESCRIPTION="Library for AVI-Files"
SRC_URI="http://avifile.sourceforge.net/${MY_P}.tgz
	mirror://gentoo/20030130.diff.bz2"
HOMEPAGE="http://avifile.sourceforge.net/"

SLOT="0.7"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND=">=media-libs/jpeg-6b
	x86? ( >=media-libs/divx4linux-20020418
		>=media-libs/win32codecs-0.90 )
	>=media-video/ffmpeg-0.4
	>=media-sound/mad-0.14
	>=media-libs/xvid-0.9.0
	>=media-sound/lame-3.90
	>=media-libs/alsa-lib-0.9.0_rc2
	>=media-sound/esound-0.2.28
	>=media-libs/audiofile-0.2.3
	truetype? ( >=media-libs/freetype-2.1 )
	xv? ( >=x11-base/xfree-4.2.1 )
	sdl? ( >=media-libs/libsdl-1.2.2 )
	dvd? ( >=media-libs/a52dec-0.7 )
	zlib? ( >=sys-libs/zlib-1.1.3 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	X? ( >=x11-base/xfree-4.2.0 >=x11-libs/xft-2.0.1 )
	qt? ( >=x11-libs/qt-3.0.3 )"

src_unpack() {
        unpack ${MY_P}.tgz
        cd ${S}
        epatch ${DISTDIR}/20030130.diff.bz2 || die
}

src_compile() {

	export WANT_AUTOCONF_2_5=1
	./autogen.sh
	elibtoolize

	local myconf=""
	local kdepre=""

	use static \
		&& myconf="${myconf} --enable-static" \
		|| myconf="${myconf} --disable-static"

	use truetype \
		&& myconf="${myconf} --enable-freetype2" \
		|| myconf="${myconf} --disable-freetype2"

	use xv \
		&& myconf="${myconf} --enable-xv" \
		|| myconf="${myconf} --disable-xv"

	if [ "$XINERAMA" = "NO" ]; then
		myconf="${myconf} --disable-xinerama"
	fi

	if [ "$DPMS" = "NO" ]; then
		myconf="${myconf} --disable-dpms"
	fi

	use sdl \
		&& myconf="${myconf} --enable-sdl" \
		|| myconf="${myconf} --disable-sdl --disable-sdltest"

	if [ "$V4L" = "NO" ]; then
		myconf="${myconf} --disable-v4l"
	fi

	use oss \
		&& myconf="${myconf} --enable-oss" \
		|| myconf="${myconf} --disable-oss"

	if [ "$SUN" = "NO" ]; then
		myconf="${myconf} --disable-sunaudio"
	fi

	use dvd \
		&& myconf="${myconf} --enable-a52 --enable-ffmpeg-a52" \
		|| myconf="${myconf} --disable-a52 --disable-ffmpeg-a52"

	if [ "$SBLIVE" = "NO" ]; then
		myconf="${myconf} --disable-ac3passthrough"
	fi

	if [ "$RUNTIME_LAME" = "YES" ]; then
		myconf="${myconf} --enable-lame-bin"
	fi

	if [ ! -z $DEBUGBUILD ]; then
		myconf="${myconf} --enable-loader-out --enable-timing"
	else
		myconf="${myconf} --enable-quiet"
	fi

	( use mmx || use sse || use 3dnow ) && myconf="${myconf} --enable-x86opt"

	use zlib \
		&& myconf="${myconf} --enable-libz" \
		|| myconf="${myconf} --disable-libz"

	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis --disable-oggtest --disable-vorbistest"

	if [ "$MGA" = "NO" ]; then
		myconf="${myconf} --disable-mga"
	fi

	if [ "$DMALLOC" = "YES" ]; then
		myconf="${myconf} --with-dmallocth"
	fi

	use X \
		&& myconf="${myconf} --with-x --enable-xft" \
		|| myconf="${myconf} --without-x --disable-xft"
	
	use qt \
		&& myconf="${myconf} --with-qt-dir=${QTDIR}" \
		|| myconf="${myconf} --without-qt"

	# Rather not use custom ones here .. build should set as high as
	# safe by itself.
	unset CFLAGS CXXFLAGS LDFLAGS CC CXX

	# Make sure we include freetype2 headers before freetype1 headers, else Xft2
	# borks, bug #11941.
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	# Fix qt detection
	cp configure configure.orig
	sed -e "s:extern \"C\" void exit(int);:/* extern \"C\" void exit(int); */:" \
		< configure.orig > configure

	econf \
		--enable-samples \
		--disable-vidix \
		--with-fpic \
		--with-gnu-ld \
		${myconf} || die
		
	export CC="gcc"
	export CXX="g++"

	emake || die
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

