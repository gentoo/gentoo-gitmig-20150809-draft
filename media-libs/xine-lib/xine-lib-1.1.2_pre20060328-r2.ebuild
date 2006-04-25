# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-1.1.2_pre20060328-r2.ebuild,v 1.1 2006/04/25 15:12:31 flameeyes Exp $

inherit eutils flag-o-matic toolchain-funcs libtool autotools

# This should normally be empty string, unless a release has a suffix.
if [[ "${P/_pre/}" == "${P}" ]]; then
	MY_PKG_SUFFIX=""
	MY_P="${PN}-${PV/_/-}${MY_PKG_SUFFIX}"
	S="${WORKDIR}/${MY_P}"

	SRC_URI="mirror://sourceforge/xine/${MY_P}.tar.gz"
else
	MY_P="${PN}-${PV/_pre/cvs}"
	S="${WORKDIR}/${MY_P/cvs*/cvs}"

	SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
fi

PATCHLEVEL="33"

DESCRIPTION="Core libraries for Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="${SRC_URI}
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"

IUSE_VIDEO_CARDS="video_cards_nvidia video_cards_via video_cards_i810"

IUSE="aalib libcaca arts esd win32codecs nls dvd X directfb vorbis alsa
gnome sdl speex theora ipv6 altivec opengl aac fbcon xv xvmc
samba dxr3 vidix mng flac oss v4l xinerama vcd a52 mad imagemagick dts asf
ffmpeg debug modplug ${IUSE_VIDEO_CARDS}"

RDEPEND="vorbis? ( media-libs/libvorbis )
	X? ( || ( (
			x11-libs/libXext
			x11-libs/libX11 )
		virtual/x11 ) )
	xv? ( || ( x11-libs/libXv virtual/x11 ) )
	xvmc? (
		|| ( x11-libs/libXvMC virtual/x11 )
		video_cards_nvidia? ( media-video/nvidia-glx )
		video_cards_via? ( || ( x11-drivers/xf86-video-via virtual/x11 ) )
		video_cards_i810? ( || ( x11-drivers/xf86-video-i810 virtual/x11 ) )
	)
	xinerama? ( || ( x11-libs/libXinerama virtual/x11 ) )
	win32codecs? ( >=media-libs/win32codecs-0.50 )
	esd? ( media-sound/esound )
	dvd? ( >=media-libs/libdvdcss-1.2.7 )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	directfb? ( >=dev-libs/DirectFB-0.9.9 )
	gnome? ( >=gnome-base/gnome-vfs-2.0 )
	flac? ( >=media-libs/flac-1.0.4 )
	sdl? ( >=media-libs/libsdl-1.1.5 )
	dxr3? ( >=media-libs/libfame-0.9.0 )
	theora? ( media-libs/libtheora )
	speex? ( media-libs/speex )
	libcaca? ( media-libs/libcaca )
	samba? ( net-fs/samba )
	mng? ( media-libs/libmng )
	vcd? ( media-video/vcdimager )
	a52? ( >=media-libs/a52dec-0.7.4-r5 )
	mad? ( media-libs/libmad )
	imagemagick? ( media-gfx/imagemagick )
	dts? ( media-libs/libdts )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20051120 )
	modplug? ( media-libs/libmodplug )
	nls? ( virtual/libintl )
	virtual/libiconv
	!=media-libs/xine-lib-0.9.13*"

DEPEND="${RDEPEND}
	X? ( || ( (
			x11-base/xorg-server
			x11-libs/libXt
			x11-proto/xextproto
			x11-proto/xproto
			x11-proto/videoproto
			x11-proto/xf86vidmodeproto
			xinerama? ( x11-proto/xineramaproto ) )
		virtual/x11 )
		)
	v4l? ( virtual/os-headers )
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/patches

	# ffmpeg doesn'g use libtool, so the condition for PIC code
	# is __PIC__, not PIC.
	sed -i -e 's/#\(\(.*def *\)\|\(.*defined *\)\|\(.*defined(*\)\)PIC/#\1__PIC__/' \
		src/libffmpeg/libavcodec/i386/dsputil_mmx{.c,_rnd.h,_avg.h} \
		src/libffmpeg/libavcodec/msmpeg4.c \
		|| die "sed failed (__PIC__)"

	AT_M4DIR="m4" eautoreconf
}

# check for the X11 path for a given library
get_x11_dir() {
	if [[ -f "${ROOT}/usr/$(get_libdir)/$1" ]]; then
		echo "${ROOT}/usr/$(get_libdir)"
	elif [[ -f "${ROOT}/usr/$(get_libdir)/xorg/$1" ]]; then
		echo "${ROOT}/usr/$(get_libdir)/xorg"
	elif [[ -f "${ROOT}/usr/X11R6/$(get_libdir)/$1" ]]; then
		echo "${ROOT}/usr/X11R6/$(get_libdir)"
	fi
}

src_compile() {
	#prevent quicktime crashing
	append-flags -frename-registers -ffunction-sections

	# Specific workarounds for too-few-registers arch...
	if [[ $(tc-arch) == "x86" ]]; then
		append-flags -UHAVE_MMX
		filter-flags -fforce-addr  # breaks ffmpeg module
		filter-flags -momit-leaf-frame-pointer # break on gcc 3.4/4.x
		append-flags -mno-sse -fomit-frame-pointer
		is-flag -O? || append-flags -O2

		ewarn ""
		ewarn "Debug information will be almost useless as the frame pointer is omitted."
		ewarn "This makes debugging harder, so crashes that has no fixed behavior are"
		ewarn "difficult to fix. Please have that in mind."
		ewarn ""
	fi

	# debug useflag used to emulate debug make targets. See bug #112980 and the
	# xine maintainers guide.
	use debug && append-flags -DDEBUG

	local myconf

	# enable/disable appropiate optimizations on sparc
	[[ "${PROFILE_ARCH}" == "sparc64" ]] && myconf="${myconf} --enable-vis"
	[[ "${PROFILE_ARCH}" == "sparc" ]] && myconf="${myconf} --disable-vis"

	# The default CFLAGS (-O) is the only thing working on hppa.
	use hppa && unset CFLAGS

	if ! use xvmc; then
		myconf="${myconf} --disable-xvmc"
	else
		count="0"
		if use video_cards_nvidia; then
			count="`expr ${count} + 1`"
			xvmclib="XvMCNVIDIA"
		fi

		if use video_cards_i810; then
			count="`expr ${count} + 1`"
			xvmclib="I810XvMC"
		fi

		if use video_cards_via; then
			count="`expr ${count} + 1`"
			xvmclib="viaXvMC"
		fi

		if [[ "${count}" -gt "1" ]]; then
			eerror "Invalid combination of USE flags"
			eerror "When building support for xvmc, you may only include support"
			eerror "for none or one of the following VIDEO_CARDS:"
			eerror ""
			eerror "nvidia i810 via"
			eerror ""
			eerror "XvMC support will try to link against libXvMCW."
		elif [[ -n "${xvmclib}" ]]; then
			xvmcconf="--with-xvmc-lib=${xvmclib} --with-xxmc-lib=${xvmclib}"
			xvmcdir=$(get_x11_dir libXvMC.so)

			[[ -z ${xvmcdir} ]] && die "Unable to find libXvMC.so."

			myconf="${myconf} ${xvmcconf} --with-xvmc-path=${xvmcdir} --with-xxmc-path=${xvmcdir}"
		fi
	fi

	if use xv; then
		xvdir=$(get_x11_dir libXv.so)

		[[ -z ${xvdir} ]] && die "Unable to find libXv.so. Did you set USE=\"xv\" when you emerged xorg-x11?"

		myconf="${myconf} --with-xv-path=${xvdir}"
	fi

	econf \
		$(use_enable gnome) \
		$(use_enable nls) \
		$(use_enable ipv6) \
		$(use_enable samba) \
		$(use_enable altivec) \
		\
		$(use_enable mng) \
		$(use_enable imagemagick) \
		\
		$(use_enable aac faad) \
		$(use_enable flac) \
		$(use_with vorbis ogg) $(use_with vorbis) \
		$(use_enable speex) \
		$(use_enable a52) --with-external-a52dec \
		$(use_enable mad) --with-external-libmad \
		$(use_enable dts) --with-external-libdts \
		\
		$(use_with X x) \
		$(use_enable xinerama) \
		$(use_enable vidix) \
		$(use_enable dxr3) \
		$(use_enable directfb) \
		$(use_enable fbcon fb) \
		$(use_enable opengl) \
		$(use_enable aalib) \
		$(use_enable libcaca caca) \
		$(use_enable sdl) \
		\
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable esd) \
		$(use_enable vcd) --without-internal-vcdlibs \
		\
		$(use_enable asf) \
		$(use_enable win32codecs w32dll) \
		$(use_enable modplug) \
		$(use_with ffmpeg external-ffmpeg) \
		--disable-polypaudio \
		--disable-optimizations \
		${myconf} \
		--with-w32-path=/usr/lib/win32 \
		--disable-dependency-tracking || die "econf failed"

		#$(use_with dvdnav external-dvdnav) \
		#$(use_enable macos macosx-video) $(use_enable macos coreaudio) \
		# This will be added when polypaudio will be added to portage.
		# $(use_enable polypaudio)

	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"

	dodoc AUTHORS ChangeLog README TODO doc/README* doc/faq/faq.txt
	dohtml doc/faq/faq.html doc/hackersguide/*.html doc/hackersguide/*.png

	rm -rf ${D}/usr/share/doc/xine
}

pkg_postinst() {
	if use win32codecs && ! use asf; then
		einfo "You choose to build win32codecs support but disabled ASF"
		einfo "demuxer. This way you'll have support for win32codecs in"
		einfo "formats like AVI or Matroska, but not in WMV/WMA files."
		einfo ""
		einfo "To be able to play WMV/WMA files, please add asf useflag."
	fi
}
