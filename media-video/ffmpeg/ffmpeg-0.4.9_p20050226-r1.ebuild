# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.9_p20050226-r1.ebuild,v 1.4 2005/03/30 07:58:44 chriswhite Exp $

inherit eutils flag-o-matic gcc

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec."
HOMEPAGE="http://ffmpeg.sourceforge.net/"
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://sourceforge/ffmpeg/${MY_P}.tbz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64 ~ppc64 ~arm ~mips ~hppa"
IUSE="aac altivec debug doc dv dvd encode imlib mmx oggvorbis oss threads truetype v4l pic xvid"

DEPEND="imlib? (media-libs/imlib2)
		truetype? (>=media-libs/freetype-2)
		sdl? (>=media-libs/libsdl-1.2.1)
		doc? (app-text/texi2html)
		encode? (media-sound/lame)
		oggvorbis? (media-libs/libvorbis
					media-libs/libogg)
		!alpha? ( aac? (media-libs/faad2 media-libs/faac) )
		dvd? (media-libs/a52dec)
		xvid? (media-libs/xvid)
		"

src_unpack() {
	unpack ${A} || die
	cd ${S}

	# for some reason it tries to #include <X11/Xlib.h>, but doesn't use it
	cd ${S}
	sed -i s:\#define\ HAVE_X11:\#define\ HAVE_LINUX: ffplay.c

	# make a52bin actually compile... adds the needed external lib
	# and makes fprintf -> av_log like it's supposed to be...
	epatch ${FILESDIR}/gentoo-${PN}001.patch

	# If MMX isn't to be built, make the libraries properly PIC
	# Also covers bug #16281
	if use pic || use !mmx; then
		#ffmpeg doesn'g use libtool, so the condition for PIC code
		#is __PIC__, not PIC.
		sed -i -e 's/#if\(\(.*def *\)\|\(.*defined *\)\)PIC/#if\1__PIC__/' \
			libavcodec/i386/dsputil_mmx{.c,_rnd.h} \
			libavcodec/msmpeg4.c \
			|| die "sed failed (__PIC__)"

		#fixup library makefiles to add '-fPIC'
		sed -i -e 's/CFLAGS=/CFLAGS=-fPIC /' \
			libav{codec,format}/Makefile \
			|| die "sed failed (-fPIC)"

		#fixup liba52 to respect the --disable-mmx configure option
		sed -i -e 's/#ifdef ARCH_X86/#ifdef HAVE_MMX/' \
			libavcodec/liba52/resample.c \
			|| die "sed failed (HAVE_MMX)"
	fi
}

src_compile() {
	#Note; library makefiles don't propogate flags from config.mak so
	#use specified CFLAGS are only used in executables
	filter-flags -fforce-addr -momit-leaf-frame-pointer

	local myconf=""

	#disable mmx accelerated code if not requirested, or if PIC is required
	# as the provided asm decidedly isn't PIC.
	if use pic || use !mmx; then
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

	econf \
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
	--enable-shared-pp \
	--enable-shared \
	--enable-pp \
	--disable-optimize \
	${myconf} \
	|| die "Configure failed"

	emake || die "Make Failed"
}

src_install() {
	use doc && make documentation
	make DESTDIR=${D} \
	prefix=${D}/usr \
	mandir=${D}/usr/share/man \
	infodir=${D}/usr/share/info \
	bindir=${D}/usr/bin \
	install installlib || die "Install Failed"

	dodoc ChangeLog README INSTALL
	dodoc doc/*

	cd ${S}/libavcodec/libpostproc
	make prefix=${D}/usr \
		install || die "Failed to install libpostproc.a!"
	make prefix=${D}/usr \
		SHARED_PP="yes" \
		install || die "Failed to install libpostproc.so!"
	cd ${S}
	# Some stuff like transcode can use this one.
	dolib ${S}/libavcodec/libpostproc/libpostproc.a

	preplib /usr
}

# FEATURES=maketest breakes the compile
src_test() { :; }
