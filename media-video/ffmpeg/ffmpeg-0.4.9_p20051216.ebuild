# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.9_p20051216.ebuild,v 1.22 2006/12/10 18:29:45 zzam Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec."
HOMEPAGE="http://ffmpeg.sourceforge.net/"
MY_P=${P/_/-}
S=${WORKDIR}
S_BASE=${WORKDIR}/${MY_P}
S_STATIC=${S_BASE}-static
S_SHARED=${S_BASE}-shared

SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# ~alpha need to test aac useflag
# ~ia64 ~arm ~mips ~hppa
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
KEYWORDS="-* alpha amd64 arm hppa ia64 ppc ~ppc-macos ppc64 sparc x86"
IUSE="aac altivec debug doc ieee1394 a52 encode imlib mmx ogg vorbis oss test theora threads truetype v4l xvid dts network zlib sdl"

DEPEND="imlib? ( media-libs/imlib2 )
	truetype? ( >=media-libs/freetype-2 )
	sdl? ( >=media-libs/libsdl-1.2.1 )
	doc? ( app-text/texi2html )
	encode? ( media-sound/lame )
	ogg? ( media-libs/libogg )
	vorbis? ( media-libs/libvorbis )
	theora? ( media-libs/libtheora )
	aac? ( media-libs/faad2 media-libs/faac )
	a52? ( >=media-libs/a52dec-0.7.4-r4 )
	xvid? ( >=media-libs/xvid-1.0.3 )
	zlib? ( sys-libs/zlib )
	dts? ( media-libs/libdts )
	ieee1394? ( =media-libs/libdc1394-1*
	            sys-libs/libraw1394 )
	test? ( net-misc/wget )"

src_unpack() {
	unpack ${A} || die
	cd ${S_BASE}

	#Append -fomit-frame-pointer to avoid some common issues
	use debug || append-flags "-fomit-frame-pointer"

	# for some reason it tries to #include <X11/Xlib.h>, but doesn't use it
	sed -i s:\#define\ HAVE_X11:\#define\ HAVE_LINUX: ffplay.c

	epatch ${FILESDIR}/ffmpeg-unknown-options.patch
	epatch ${FILESDIR}/ffmpeg-soname-symlink.patch
	epatch "${FILESDIR}/${P}-asneeded-configure.patch"

	# ffmpeg doesn'g use libtool, so the condition for PIC code
	# is __PIC__, not PIC.
	sed -i -e 's/#\(\(.*def *\)\|\(.*defined *\)\|\(.*defined(*\)\)PIC/#\1__PIC__/' \
		libavcodec/i386/dsputil_mmx{.c,_rnd.h,_avg.h} \
		libavcodec/msmpeg4.c \
		libavutil/common.h \
		|| die "sed failed (__PIC__)"

	# Make it use pic always since we don't need textrels
	sed -i -e "s:LIBOBJFLAGS=\"\":LIBOBJFLAGS=\'\$\(PIC\)\':" configure

	# To make sure the ffserver test will work
	sed -i -e "s:-e debug=off::" tests/server-regression.sh
	cd ${S}
	cp -R ${S_BASE} ${S_STATIC}
	mv ${S_BASE} ${S_SHARED}

	# Patch for gcc-4 shared build only
	cd ${S_SHARED}
	epatch ${FILESDIR}/ffmpeg-shared-gcc4.patch
}

src_compile() {
	#Note; library makefiles don't propogate flags from config.mak so
	#use specified CFLAGS are only used in executables
	replace-flags -O0 -O2

	local myconf=""

	#disable mmx accelerated code if not requirested, or if PIC is required
	# as the provided asm decidedly is not PIC.
	if ( ! has_pic && use mmx ) || use amd64; then
		myconf="${myconf} --enable-mmx"
	else
		myconf="${myconf} --disable-mmx"
	fi

	if use elibc_FreeBSD; then
		myconf="${myconf} --enable-memalign-hack"
	fi

	myconf="${myconf}
		$(use_enable altivec) \
		$(use_enable debug) \
		$(use_enable encode mp3lame) \
		$(use_enable a52) --disable-a52bin \
		$(use_enable oss audio-oss) \
		$(use_enable v4l) \
		$(use_enable ieee1394 dv1394) $(use_enable ieee1394 dc1394) \
		$(use_enable threads pthreads) \
		$(use_enable xvid) \
		$(use_enable ogg libogg) \
		$(use_enable vorbis) \
		$(use_enable theora) \
		$(use_enable dts) \
		$(use_enable network) \
		$(use_enable zlib) \
		$(use_enable sdl ffplay) \
		$(use_enable aac faad) $(use_enable aac faac) --disable-faadbin \
		--cc=$(tc-getCC) \
		--enable-gpl \
		--enable-pp \
		--disable-opts \
		--disable-strip"

	cd ${S_STATIC}
	econf --disable-shared-pp --disable-shared --enable-static \
		"--extra-ldflags=${LDFLAGS}" \
		${myconf} || die "Configure failed"
	emake || die "static failed"

	# Specific workarounds for too-few-registers arch...
	if [[ $(tc-arch) == "x86" ]]; then
		filter-flags -fforce-addr -momit-leaf-frame-pointer
		append-flags -fomit-frame-pointer
		is-flag -O? || append-flags -O2
		ewarn ""
		ewarn "Debug information will be almost useless as the frame pointer is omitted."
		ewarn "This makes debugging harder, so crashes that has no fixed behavior are"
		ewarn "difficult to fix. Please have that in mind."
		ewarn ""
	fi

	cd ${S_SHARED}
	econf --enable-shared-pp --enable-shared --disable-static \
		"--extra-ldflags=${LDFLAGS}" \
		${myconf} || die "Configure failed"
	emake || die "shared failed"
}

src_install() {
	for d in ${S_STATIC} ${S_SHARED}; do
		cd ${d}

		make DESTDIR=${D} \
			prefix=${D}/usr \
			libdir=${D}/usr/$(get_libdir) \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			bindir=${D}/usr/bin \
			install installlib || die "Install Failed"
	done

	cd ${S_SHARED}
	use doc && make documentation
	dodoc Changelog README INSTALL
	dodoc doc/*

	cd ${S_STATIC}/libavcodec/libpostproc
	make prefix=${D}/usr libdir=${D}/usr/$(get_libdir) \
		install || die "Failed to install libpostproc.a!"

	cd ${S_SHARED}/libavcodec/libpostproc
	make prefix=${D}/usr libdir=${D}/usr/$(get_libdir) \
		SHARED_PP="yes" \
		install || die "Failed to install libpostproc.so!"

	# Some stuff like transcode can use this one.
	dolib ${S_STATIC}/libavcodec/libpostproc/libpostproc.a

	preplib /usr
}

# Never die for now...
src_test() {

	for d in ${S_STATIC} ${S_SHARED}; do
		cd ${d}/tests
		for t in "codectest libavtest test-server" ; do
			make ${t} || ewarn "Some tests in ${t} failed for ${d}"
		done
	done
}

pkg_postinst() {

	ewarn "ffmpeg may had ABI changes, if ffmpeg based programs"
	ewarn "like xine-lib or vlc stop working as expected please"
	ewarn "rebuild them."

}
