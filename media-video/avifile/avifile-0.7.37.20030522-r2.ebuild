# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.37.20030522-r2.ebuild,v 1.15 2004/11/30 20:00:50 chriswhite Exp $

inherit eutils

MAJ_PV=${PV:0:3}
MIN_PV=${PV:3:3}
MY_P="${P/.200/-200}"
MY_S="${PN}${MAJ_PV}-${MAJ_PV}${MIN_PV}"
S="${WORKDIR}/${MY_S}"

DESCRIPTION="Library for AVI-Files"
HOMEPAGE="http://avifile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0.7"
KEYWORDS="~x86 ~sparc alpha ia64"
IUSE="3dnow X alsa avi debug dvd esd mmx oggvorbis qt sdl sse static truetype xv zlib"

DEPEND=">=media-libs/jpeg-6b
	x86? ( >=media-libs/divx4linux-20020418
		>=media-libs/win32codecs-0.90 )
	>=media-video/ffmpeg-0.4
	>=media-libs/xvid-0.9.0
	>=media-sound/lame-3.90
	>=media-libs/audiofile-0.2.3
	>=sys-apps/sed-4
	>=media-sound/madplay-0.14.2b
	truetype? ( >=media-libs/freetype-2.1 )
	xv? ( virtual/x11 )
	sdl? ( >=media-libs/libsdl-1.2.2 )
	dvd? ( >=media-libs/a52dec-0.7 )
	zlib? ( >=sys-libs/zlib-1.1.3 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	X? ( virtual/x11 virtual/xft )
	qt? ( >=x11-libs/qt-3.0.3 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	esd? ( >=media-sound/esound-0.2.28 )"

src_unpack() {
	unpack ${A}
	use qt || sed -i 's/qt[a-z]*//g' ${S}/samples/Makefile.am
	#Fixing divx 2003 API
	if has_version  '>=media-libs/divx4linux-20030428'
	then
		einfo "DivX 20030428 found"
		cd ${S}
		epatch ${FILESDIR}/${P}-divx.patch
	else
		einfo "Old DivX Api found"
	fi
}

src_compile() {
	local myconf="--enable-oss"
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

	if [ "$SUN" = "NO" ]; then
		myconf="${myconf} --disable-sunaudio"
	fi

	use dvd \
		&& myconf="${myconf} --enable-a52 --enable-ffmpeg-a52" \
		|| myconf="${myconf} --disable-a52 --disable-ffmpeg-a52"

	if [ "$SBLIVE" = "NO" ]; then
		myconf="${myconf} --disable-ac3passthrough"
	fi

	use debug \
		&& myconf="${myconf} --enable-loader-out" \
		|| myconf="${myconf} --enable-quiet"

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
		&& myconf="${myconf} --with-qt-prefix=${QTDIR}" \
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
		--enable-lame-bin \
		${myconf} || die
	emake || die
}

src_install() {
	dodir /usr/lib /usr/bin
	use avi && dodir /usr/lib/win32

	einstall || die

	cd ${S}
	dodoc COPYING README INSTALL
	cd doc
	dodoc CREDITS EXCEPTIONS FreeBSD LICENSING TODO
	dodoc VIDEO-PERFORMANCE WARNINGS KNOWN_BUGS
}

pkg_postinst() {
	einfo "In order to use certain video modes, you must be root"
	einfo "chmod +s /usr/bin/aviplay to suid root"
	einfo "As this is considered a security risk on multiuser"
	einfo "systems, this is not done by default"
}
