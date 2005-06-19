# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avifile/avifile-0.7.43.20050224-r1.ebuild,v 1.7 2005/06/19 15:59:58 gmsoft Exp $

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

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips sparc ~x86 hppa"
IUSE="3dnow X alsa debug divx4linux dmalloc dpms a52 encode esd mad matrox
mmx vorbis oss qt sblive sdl sse truetype v4l vidix win32codecs xinerama xv xvid
zlib"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	win32codecs? ( >=media-libs/win32codecs-0.90 )
	divx4linux? ( >=media-libs/divx4linux-20030428 )
	dmalloc? ( !amd64? ( !arm? ( !mips? ( dev-libs/dmalloc ) ) ) )
	a52? ( >=media-libs/a52dec-0.7 )
	encode? ( >=media-sound/lame-3.90 )
	esd? ( >=media-sound/esound-0.2.28 )
	mad? ( media-libs/libmad )
	vorbis? ( >=media-libs/libvorbis-1.0 )
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
	>=sys-devel/autoconf-2.59
	>=sys-devel/automake-1.4_p6
	sys-devel/libtool"
#	v4l needs linux headers
#	v4l? ( virtual/os-headers )

pkg_setup() {
	if use qt && use dmalloc; then
		die "Sorry, qt and dmalloc can't be enabled at the same time."
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/avifile-0.7.43.20050224-sysffmpeg.patch
	# removes sed-out of -L/usr/lib(64?) on sdl libs flags
	epatch ${FILESDIR}/avifile-0.7.43.20050224-sdllibs.patch
	# fixes bug #86320
	epatch ${FILESDIR}/${P}-fixlabels.patch
	# fix building with gcc4
	# http://debian-amd64.alioth.debian.org/gcc-3.4/patches/avifile_0.7.43.20050224-1.0.0.1.gcc4.patch
	epatch ${FILESDIR}/${P}-1.0.0.1.gcc4.patch

	if ! use qt ; then
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

	# fixes mad FPM detection
	epatch ${FILESDIR}/${PN}-mad.patch

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
		$(use_enable win32codecs win32) \
		$(use_with dmalloc dmallocth) \
		$(use_enable a52) $(use_enable a52 ffmpeg-a52) \
		$(use_enable dpms) \
		$(use_enable mad) $(use_enable mad libmad) \
		$(use_enable matrox mga) \
		$(use_enable vorbis) \
		$(use_enable oss) \
		$(use_with qt) \
		$(use_enable sblive ac3passthrough) \
		$(use_with sdl) \
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

	dodoc README
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
