# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.38.20030710-r1.ebuild,v 1.2 2004/07/14 21:30:10 agriffis Exp $

inherit eutils

MAJ_PV=${PV:0:3}
MIN_PV=${PV:0:6}
MY_P="${PN}-${MAJ_PV}-${MIN_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Library for AVI-Files"
HOMEPAGE="http://avifile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0.7"
KEYWORDS="x86 ~sparc alpha amd64 ia64"
IUSE="3dnow X alsa avi debug dvd esd mmx oggvorbis qt sdl sse static truetype xv zlib"

DEPEND=">=media-libs/jpeg-6b
	x86? ( >=media-libs/divx4linux-20030428
		>=media-libs/win32codecs-0.90 )
	>=media-video/ffmpeg-0.4
	>=media-libs/xvid-0.9.0
	>=media-sound/lame-3.90
	>=media-libs/audiofile-0.2.3
	>=sys-apps/sed-4
	>=media-sound/madplay-0.14.2b
	>=sys-devel/patch-2.5.9
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

	epatch ${FILESDIR}/flvenc-patch
	epatch ${FILESDIR}/${P}-2.6.patch
	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
	use sparc && epatch ${FILESDIR}/${P}-sparc.patch
	epatch ${FILESDIR}/avifile-gcc34.patch
	epatch ${FILESDIR}/avifile-x86-gcc34.patch

	# make sure pkgconfig file is correct #53183
	cd ${S}
	rm -f avifile.pc
	sed -i "/^includedir=/s:avifile$:avifile-${PV:0:3}:" avifile.pc.in
}

src_compile() {
	local myconf="--enable-oss"
	local kdepre=""

	if [ "$XINERAMA" = "NO" ]; then
		myconf="${myconf} --disable-xinerama"
	fi

	if [ "$DPMS" = "NO" ]; then
		myconf="${myconf} --disable-dpms"
	fi

	if [ "$V4L" = "NO" ]; then
		myconf="${myconf} --disable-v4l"
	fi

	if [ "$SUN" = "NO" ]; then
		myconf="${myconf} --disable-sunaudio"
	fi

	if [ "$SBLIVE" = "NO" ]; then
		myconf="${myconf} --disable-ac3passthrough"
	fi

	use debug \
		&& myconf="${myconf} --enable-loader-out" \
		|| myconf="${myconf} --enable-quiet"

	( use mmx || use sse || use 3dnow ) && myconf="${myconf} --enable-x86opt"

	if [ "$MGA" = "NO" ]; then
		myconf="${myconf} --disable-mga"
	fi

	if [ "$DMALLOC" = "YES" ]; then
		myconf="${myconf} --with-dmallocth"
	fi

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
	sed -i \
		-e "s:extern \"C\" void exit(int);:/* extern \"C\" void exit(int); */:" \
		configure

	econf \
		`use_enable static` \
		`use_enable truetype freetype2` \
		`use_enable xv` \
		`use_enable sdl` `use_enable sdl sdltest` \
		`use_enable dvd a52` `use_enable dvd ffmpeg-a52` \
		`use_enable zlib libz` \
		`use_enable oggvorbis vorbis` `use_enable oggvorbis oggtest` `use_enable oggvorbis vorbistest` \
		`use_with X x` `use_enable X xft` \
		--enable-samples \
		--disable-vidix \
		--with-fpic \
		--enable-lame-bin \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	dodir /usr/lib /usr/bin
	use avi && dodir /usr/lib/win32

	make install DESTDIR=${D} || die

	dodoc README INSTALL
	cd doc
	dodoc CREDITS EXCEPTIONS TODO VIDEO-PERFORMANCE WARNINGS KNOWN_BUGS
}

pkg_postinst() {
	einfo "In order to use certain video modes, you must be root"
	einfo "chmod +s /usr/bin/aviplay to suid root"
	einfo "As this is considered a security risk on multiuser"
	einfo "systems, this is not done by default"
}
