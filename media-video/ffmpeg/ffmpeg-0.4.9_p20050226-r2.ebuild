# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.9_p20050226-r2.ebuild,v 1.1 2005/03/18 23:28:48 chriswhite Exp $

inherit eutils flag-o-matic gcc multilib

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec."
HOMEPAGE="http://ffmpeg.sourceforge.net/"
MY_P=${P/_/-}
S=${WORKDIR}
S_BASE=${WORKDIR}/${MY_P}
S_STATIC=${S_BASE}-static
S_SHARED=${S_BASE}-shared

SRC_URI="mirror://sourceforge/ffmpeg/${MY_P}.tbz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64 ~ppc64 ~arm ~mips ~hppa"
IUSE="aac altivec debug doc dv dvd encode imlib mmx oggvorbis oss threads truetype v4l xvid"

DEPEND="imlib? (media-libs/imlib2)
		truetype? (>=media-libs/freetype-2)
		sdl? (>=media-libs/libsdl-1.2.1)
		doc? (app-text/texi2html)
		encode? (media-sound/lame)
		oggvorbis? (media-libs/libvorbis
					media-libs/libogg)
		!alpha?( aac? (media-libs/faad2 media-libs/faac) )
		dvd? (>=media-libs/a52dec-0.7.4-r4)
		xvid? (media-libs/xvid)
		"

src_unpack() {
	unpack ${A} || die
	cd ${S_BASE}

	# for some reason it tries to #include <X11/Xlib.h>, but doesn't use it
	sed -i s:\#define\ HAVE_X11:\#define\ HAVE_LINUX: ffplay.c

	# make a52bin actually compile... adds the needed external lib
	# and makes fprintf -> av_log like it's supposed to be...
	epatch ${FILESDIR}/gentoo-${PN}001.patch

	#ffmpeg doesn'g use libtool, so the condition for PIC code
	#is __PIC__, not PIC.
	sed -i -e 's/#if\(\(.*def *\)\|\(.*defined *\)\)PIC/#if\1__PIC__/' \
		libavcodec/i386/dsputil_mmx{.c,_rnd.h} \
		libavcodec/msmpeg4.c \
		|| die "sed failed (__PIC__)"

	#fixup liba52 to respect the --disable-mmx configure option
	sed -i -e 's/#ifdef ARCH_X86/#ifdef HAVE_MMX/' \
		libavcodec/liba52/resample.c \
		|| die "sed failed (HAVE_MMX)"

	epatch ${FILESDIR}/${PN}-libdir-pic.patch

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
	if has_pic || use !mmx; then
		myconf="${myconf} --disable-mmx"
	else
		myconf="${myconf} --enable-mmx"
	fi

	use encode && use aac && myconf="${myconf} --enable-faac"

	if use oggvorbis ; then
		myconf="${myconf} --enable-ogg --enable-vorbis"
	else
		myconf="${myconf} --disable-ogg --disable-theora"
	fi

	use !alpha && myconf="${myconf} $(use_enable aac faad) $(use_enable aac faac) $(use_enable aac faadbin)"

	myconf="${myconf}
		$(use_enable altivec) \
		$(use_enable debug) \
		$(use_enable encode mp3lame) \
		$(use_enable dvd a52) $(use_enable dvd a52bin) \
		$(use_enable oss audio-oss) \
		$(use_enable v4l) \
		$(use_enable dv dv1394) \
		$(use_enable threads pthreads) \
		$(use_enable xvid) \
		--enable-gpl \
		--enable-pp \
		--disable-optimize"

	cd ${S_STATIC}
	econf --disable-shared-pp --disable-shared --enable-static ${myconf} || die "Configure failed"
	emake || die

	cd ${S_SHARED}
	econf --enable-shared-pp --enable-shared --disable-static ${myconf} || die "Configure failed"
	emake || die
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
