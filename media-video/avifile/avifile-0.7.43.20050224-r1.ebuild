# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.43.20050224-r1.ebuild,v 1.1 2005/03/26 04:27:13 eradicator Exp $

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

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~sparc ~x86"
IUSE="3dnow X alsa debug divx4linux dmalloc dpms dvd encode esd mad matrox
mmx oggvorbis oss qt sblive sdl sse truetype v4l vidix xinerama xv xvid zlib"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	x86? ( >=media-libs/win32codecs-0.90 )
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
	>=media-video/ffmpeg-0.4.9_p20050226-r2
	>=media-libs/jpeg-6b"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/autoconf-2.59
	>=sys-devel/automake-1.4_p6
	sys-devel/libtool"

src_unpack() {
	unpack ${A}

	# fixes mad FPM detection
	epatch ${FILESDIR}/${PN}-mad.patch

	epatch ${FILESDIR}/avifile-0.7.43.20050224-sysffmpeg.patch

	if use !qt ; then
		sed -i -e 's/qtvidcap\ qtrecompress//g' \
		${S}/samples/Makefile.am || die "qt based sample test removal failed"
	fi

	# Fix hardcoded Xrender linking, bug #68899
	if ! use X; then
		sed -i -e 's/-lXrender//g' ${S}/lib/video/Makefile.* || die "sed failed (Xrender)"
	fi

	# Stop them from stripping out -g
	sed -i -e "s:| sed s/-g//::" ${S}/configure{,.ac} || die "sed failed (-g)"

	# Run autotools...
	cd ${S}
	[[ -f configure.ac && -f configure.in ]] && rm configure.in

	export WANT_AUTOMAKE=1.6
	export WANT_AUTOCONF=2.5
	libtoolize --force --copy || die "libtoolize failed"
	aclocal -I ${S}/m4 || die "aclocal failed"
	autoheader || die "autoheader failed"
	automake --gnu --add-missing --include-deps --force-missing --copy || die "automake failed"
	autoconf || die "autoconf failed"

	# make sure pkgconfig file is correct #53183
	rm -f avifile.pc
}

src_compile() {
	local myconf=""
	local kdepre=""

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
		$(use_enable x86 win32) \
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
