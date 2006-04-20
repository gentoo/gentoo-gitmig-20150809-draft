# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.9_p20060302.ebuild,v 1.13 2006/04/20 21:57:34 dang Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec."
HOMEPAGE="http://ffmpeg.sourceforge.net/"
MY_P=${P/_/-}
S=${WORKDIR}
S_BASE=${WORKDIR}/${MY_P}
S_STATIC=${S_BASE}-static
S_SHARED=${S_BASE}-shared

SRC_URI="mirror://gentoo/${MY_P}.tar.bz2
	amr? ( http://www.3gpp.org/ftp/Specs/archive/26_series/26.104/26104-510.zip
	       http://www.3gpp.org/ftp/Specs/archive/26_series/26.204/26204-510.zip )"

LICENSE="GPL-2"
SLOT="0"
# ~alpha need to test aac useflag
# ~ia64 ~arm ~mips ~hppa
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="aac altivec amr debug doc ieee1394 a52 encode imlib mmx ogg vorbis oss
	test theora threads truetype v4l x264 xvid dts network zlib sdl"

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
	xvid? ( >=media-libs/xvid-1.1.0 )
	zlib? ( sys-libs/zlib )
	dts? ( media-libs/libdts )
	ieee1394? ( =media-libs/libdc1394-1*
	            sys-libs/libraw1394 )
	test? ( net-misc/wget )
	x264? ( media-libs/x264-svn )
	amr? ( app-arch/unzip )"

src_unpack() {
	unpack ${A} || die
	cd ${S_BASE}

	# amr (float) support
	if use amr; then
		einfo "Including amr wide and narrow band (float) support ... "

		# narrow band codec
		mkdir ${S_BASE}/libavcodec/amr_float
		cd ${S_BASE}/libavcodec/amr_float
		unzip -q ${WORKDIR}/26104-510_ANSI_C_source_code.zip

		# wide band codec
		mkdir ${S_BASE}/libavcodec/amrwb_float
		cd ${S_BASE}/libavcodec/amrwb_float
		unzip -q ${WORKDIR}/26204-510_ANSI-C_source_code.zip

		# Patch if we're on 64-bit
		if useq alpha || useq amd64 || useq ia64 || useq ppc64; then
			cd ${S_BASE}
			epatch ${FILESDIR}/${P}-amr-64bit.patch
		fi
	fi

	cd ${S_BASE}

	#Append -fomit-frame-pointer to avoid some common issues
	use debug || append-flags "-fomit-frame-pointer"

	# for some reason it tries to #include <X11/Xlib.h>, but doesn't use it
	sed -i s:\#define\ HAVE_X11:\#define\ HAVE_LINUX: ffplay.c

	epatch ${FILESDIR}/ffmpeg-unknown-options.patch
	epatch "${FILESDIR}/${PN}-0.4.9_p20051216-asneeded-configure.patch"
	epatch "${FILESDIR}/${P}-fbsd-flags.patch"

	# .pc files contain wrong libdir path
	epatch ${FILESDIR}/${PN}-libdir.patch
	sed -i -e "s:GENTOOLIBDIR:$(get_libdir):" configure

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
	cd ${S_SHARED}
	epatch "${FILESDIR}/ffmpeg-shared-gcc4.1.patch"
}

src_compile() {
	#Note; library makefiles don't propogate flags from config.mak so
	#use specified CFLAGS are only used in executables
	replace-flags -O0 -O2

	local myconf=""

	#disable mmx accelerated code if not requested, or if PIC is required
	# as the provided asm decidedly is not PIC.
	if ( gcc-specs-pie || ! use mmx ) && ( ! use amd64 ); then
		myconf="${myconf} --disable-mmx"
	fi

	if use elibc_FreeBSD; then
		myconf="${myconf} --enable-memalign-hack"
	fi

	# enabled by default
	use altivec || myconf="${myconf} --disable-altivec"
	use debug || myconf="${myconf} --disable-debug"
	use oss || myconf="${myconf} --disable-audio-oss"
	use v4l || myconf="${myconf} --disable-v4l --disable-v4l2"
	use ieee1394 || myconf="${myconf} --disable-dv1394"
	use network || myconf="${myconf} --disable-network"
	use zlib || myconf="${myconf} --disable-zlib"
	use sdl || myconf="${myconf} --disable-ffplay"

	myconf="${myconf} --disable-opts"

	# disabled by default
	use encode && myconf="${myconf} --enable-mp3lame"
	use a52 && myconf="${myconf} --enable-a52"
	use ieee1394 && myconf="${myconf} --enable-dc1394"
	use threads && myconf="${myconf} --enable-pthreads"
	use xvid && myconf="${myconf} --enable-xvid"
	use ogg && myconf="${myconf} --enable-libogg"
	use vorbis && myconf="${myconf} --enable-vorbis"
	use theora && myconf="${myconf} --enable-theora"
	use dts && myconf="${myconf} --enable-dts"
	use x264 && myconf="${myconf} --enable-x264"
	use aac && myconf="${myconf} --enable-faad --enable-faac"
	use amr && myconf="${myconf} --enable-amr_nb --enable-amr_wb"

	myconf="${myconf} --enable-gpl --enable-pp --disable-strip"

	cd ${S_STATIC}
	#econf generates configure options unknown to ffmpeg's configure, so configure manually
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-static --disable-shared \
		"--cc=$(tc-getCC)" \
		"--extra-ldflags=${LDFLAGS}" \
		${myconf} || die "static failed"


	emake || die "static failed"

	# Specific workarounds for too-few-registers arch...
	if [[ $(tc-arch) == "x86" ]]; then
		filter-flags -fforce-addr -momit-leaf-frame-pointer
		append-flags -fomit-frame-pointer
		is-flag -O? || append-flags -O2
		if (use debug); then
			# no need to warn about debug if not using debug flag
			ewarn ""
			ewarn "Debug information will be almost useless as the frame pointer is omitted."
			ewarn "This makes debugging harder, so crashes that has no fixed behavior are"
			ewarn "difficult to fix. Please have that in mind."
			ewarn ""
		fi
	fi

	cd ${S_SHARED}
	#econf generates configure options unknown to ffmpeg's configure, so configure manually
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--disable-static --enable-shared \
		"--cc=$(tc-getCC)" \
		"--extra-ldflags=${LDFLAGS}" \
		${myconf} || die "shared failed"

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
			install install-libs || die "Install Failed"
	done

	cd ${S_SHARED}
	use doc && make documentation
	dodoc ChangeLog README INSTALL
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
