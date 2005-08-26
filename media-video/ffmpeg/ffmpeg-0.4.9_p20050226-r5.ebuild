# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.9_p20050226-r5.ebuild,v 1.13 2005/08/26 16:00:51 seemant Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec."
HOMEPAGE="http://ffmpeg.sourceforge.net/"
MY_P=${P/_/-}
S=${WORKDIR}
S_BASE=${WORKDIR}/${MY_P}
S_STATIC=${S_BASE}-static
S_SHARED=${S_BASE}-shared

SRC_URI="mirror://sourceforge/ffmpeg/${MY_P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
# ~alpha need to test aac useflag
# ~ia64 ~arm ~mips ~hppa
KEYWORDS="~alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="aac altivec debug doc ieee1394 a52 encode imlib mmx ogg vorbis oss threads truetype v4l xvid dts network zlib sdl"

# Theora support has switch but there's no oggtheora.c sourcefile...

DEPEND="imlib? ( media-libs/imlib2 )
	truetype? ( >=media-libs/freetype-2 )
	sdl? ( >=media-libs/libsdl-1.2.1 )
	doc? ( app-text/texi2html )
	encode? ( media-sound/lame )
	ogg? ( media-libs/libogg )
	vorbis? ( media-libs/libvorbis )
	aac? ( media-libs/faad2 media-libs/faac )
	a52? ( >=media-libs/a52dec-0.7.4-r4 )
	xvid? ( >=media-libs/xvid-1.0 )
	zlib? ( sys-libs/zlib )
	dts? ( media-libs/libdts )
	ieee1394? ( media-libs/libdc1394
	            sys-libs/libraw1394 )"

src_unpack() {
	unpack ${A} || die
	cd ${S_BASE}

	#Append -fomit-frame-pointer to avoid some common issues
	use debug || append-flags "-fomit-frame-pointer"

	# for some reason it tries to #include <X11/Xlib.h>, but doesn't use it
	sed -i s:\#define\ HAVE_X11:\#define\ HAVE_LINUX: ffplay.c

	# Fix building with gcc4
	epatch ${FILESDIR}/${P}-gcc4.patch

	#ffmpeg doesn'g use libtool, so the condition for PIC code
	#is __PIC__, not PIC.
	sed -i -e 's/#\(\(.*def *\)\|\(.*defined *\)\|\(.*defined(*\)\)PIC/#\1__PIC__/' \
		libavcodec/i386/dsputil_mmx{.c,_rnd.h,_avg.h} \
		libavcodec/msmpeg4.c \
		libavcodec/common.h \
		|| die "sed failed (__PIC__)"

	epatch ${FILESDIR}/${PN}-libdir-pic.patch
	epatch ${FILESDIR}/${PN}-a52.patch
	epatch ${FILESDIR}/${PN}-missing_links.patch

	cd ${S}
	cp -R ${S_BASE} ${S_STATIC}
	mv ${S_BASE} ${S_SHARED}
}

src_compile() {
	#Note; library makefiles don't propogate flags from config.mak so
	#use specified CFLAGS are only used in executables
	filter-flags -fforce-addr -momit-leaf-frame-pointer

	local myconf=""

	#disable mmx accelerated code if not requirested, or if PIC is required
	# as the provided asm decidedly isn't PIC.
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
		$(use_enable ogg) \
		$(use_enable vorbis) \
		$(use_enable dts) \
		$(use_enable network) \
		$(use_enable zlib) \
		$(use_enable sdl ffplay) \
		$(use_enable aac faad) $(use_enable aac faac) --disable-faadbin \
		--enable-gpl \
		--enable-pp \
		--disable-opts"

	cd ${S_STATIC}
	econf --disable-shared-pp --disable-shared --enable-static ${myconf} || die "Configure failed"
	emake CC="$(tc-getCC)" || die "static failed"

	cd ${S_SHARED}
	econf --enable-shared-pp --enable-shared --disable-static ${myconf} || die "Configure failed"
	emake CC="$(tc-getCC)" || die "shared failed"
}

src_install() {
	for d in ${S_STATIC} ${S_SHARED}; do
		cd ${d}

		use doc && make documentation
		make DESTDIR=${D} \
			prefix=${D}/usr \
			libdir=${D}/usr/$(get_libdir) \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			bindir=${D}/usr/bin \
			install installlib || die "Install Failed"
	done

	cd ${S_SHARED}
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

	preplib /usr
}

# FEATURES=maketest breakes the compile
src_test() { :; }
