# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.43.20050224.ebuild,v 1.1 2005/03/22 07:01:25 chriswhite Exp $

inherit eutils flag-o-matic

MAJ_PV=${PV:0:3}
MIN_PV=${PV:0:6}
MY_P="${PN}-${MAJ_PV}-${MIN_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Library for AVI-Files"
HOMEPAGE="http://avifile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.7"

#-sparc: 0.7.41 - dsputil_init_vis undefined - eradicator
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips -sparc ~x86"
IUSE="3dnow X alsa avi debug divx4linux dmalloc dpms dvd encode esd mad matrox
mmx oggvorbis oss qt sblive sdl sse static truetype v4l vidix xinerama xv xvid zlib"

DEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	avi? ( x86? ( >=media-libs/win32codecs-0.90 ) )
	alsa? ( virtual/alsa )
	divx4linux? ( x86? ( >=media-libs/divx4linux-20030428 ) )
	dmalloc? ( !amd64? ( !arm? ( !mips? ( dev-libs/dmalloc ) ) ) )
	dvd? ( >=media-libs/a52dec-0.7 )
	encode? ( >=media-sound/lame-3.90 )
	esd? ( >=media-sound/esound-0.2.28 )
	mad? ( media-libs/libmad )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	qt? ( >=x11-libs/qt-3.0.3 )
	sdl? ( >=media-libs/libsdl-1.2.2 )
	truetype? ( >=media-libs/freetype-2.1 )
	xv? ( virtual/x11 )
	xvid? ( =media-libs/xvid-1* )
	X? ( virtual/x11 virtual/xft )
	zlib? ( >=sys-libs/zlib-1.1.3 )
	>=media-libs/jpeg-6b
	>=sys-apps/sed-4
	>=sys-devel/patch-2.5.9"

src_unpack() {
	unpack ${A}

	# fixes mad FPM detection
	epatch ${FILESDIR}/${PN}-mad.patch

	if use !qt ; then
		sed -i -e 's/qtvidcap\ qtrecompress//g' \
		${S}/samples/Makefile.am || die "qt based sample test removal failed"
	fi

	# make sure pkgconfig file is correct #53183
	cd ${S}
	if use sparc; then
		sed -i -e "s:AM_CFLAGS.*:AM_CFLAGS = -O2:" \
		${S}/ffmpeg/libavcodec/postproc/Makefile.* \
		|| die "Could not tune down CFLAGS for postproc"
	fi

	rm -f avifile.pc

	sed -e "s:| sed s/-g//::" -i configure || die "sed failed (-g)"

	# Fix qt detection
	sed -i \
		-e "s:extern \"C\" void exit(int);:/* extern \"C\" void exit(int); */:" \
		configure || die "sed failed (qt detection)"

	# Fix hardcoded Xrender linking, bug #68899
	if ! use X; then
		sed -e 's/-lXrender//g' -i lib/video/Makefile.* \
		|| die "sed failed (Xrender)"
	fi

	# adding CFLAGS by default which exists only for x86 is no good idea
	# but I can't get it through gcc 3.4.3 without omit-frame-pointer
	if use x86; then
		find . -name "Makefile.in" | while read file; do
			sed -e "s/^AM_CFLAGS = .*/AM_CFLAGS = -fomit-frame-pointer/" -i $file
		done
	fi
}

src_compile() {
	local myconf=""
	local kdepre=""

	use sparc \
		&& myconf="${myconf} --enable-sunaudio" \
		|| myconf="${myconf} --disable-sunaudio"

	use debug \
		&& myconf="${myconf} --enable-loader-out" \
		|| myconf="${myconf} --enable-quiet"

	( use mmx || use sse || use 3dnow ) && myconf="${myconf} --enable-x86opt"

	use encode \
		&& myconf="${myconf} --disable-lame --enable-lamebin" \
		|| myconf="${myconf} --enable-lame --disable-lamebin"

	# Make sure we include freetype2 headers before freetype1 headers, else Xft2
	# borks, bug #11941.
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	filter-flags "-momit-leaf-frame-pointer"

	export FFMPEG_CFLAGS="${CFLAGS}"

	econf \
		$(use_enable avi win32) \
		$(use_with dmalloc dmallocth) \
		$(use_enable dvd a52) $(use_enable dvd ffmpeg-a52) \
		$(use_enable dpms) \
		$(use_enable mad) $(use_enable libmad) \
		$(use_enable matrox mga) \
		$(use_enable oggvorbis vorbis) $(use_enable oggvorbis oggtest) $(use_enable oggvorbis vorbistest) \
		$(use_enable oss) \
		$(use_with qt) \
		$(use_enable sblive ac3passthrough) \
		$(use_enable sdl) $(use_enable sdl sdltest) \
		$(use_enable static) \
		$(use_enable truetype freetype2) \
		$(use_enable v4l) \
		$(use_enable vidix) \
		$(use_with X x) $(use_enable X xft) \
		$(use_enable xv) \
		$(use_enable xvid xvid4) --disable-xvid \
		$(use_enable zlib libz) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc README INSTALL
	cd doc
	dodoc CREDITS EXCEPTIONS TODO VIDEO-PERFORMANCE WARNINGS KNOWN_BUGS
}

src_test() {
	ewarn "Testing disabled for this ebuild."
}

pkg_postinst() {
	if use qt; then # else no aviplay built
		einfo "In order to use certain video modes, you must be root"
		einfo "chmod +s /usr/bin/aviplay to suid root"
		einfo "As this is considered a security risk on multiuser"
		einfo "systems, this is not done by default"
	fi
}
