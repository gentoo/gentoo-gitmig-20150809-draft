# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-1.1.0.ebuild,v 1.8 2005/08/24 19:34:32 gustavoz Exp $

inherit eutils flag-o-matic toolchain-funcs libtool

# This should normally be empty string, unless a release has a suffix.
MY_PKG_SUFFIX=""
MY_P=${PN}-${PV/_/-}${MY_PKG_SUFFIX}

PATCHLEVEL="10"

DESCRIPTION="Core libraries for Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${MY_P}.tar.gz
	http://digilander.libero.it/dgp85/gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE="aalib libcaca arts cle266 esd win32codecs nls dvd X directfb vorbis alsa
gnome sdl speex theora ipv6 altivec opengl aac fbcon xv xvmc nvidia i8x0
samba dxr3 vidix mng flac oss v4l xinerama vcd a52 mad imagemagick"
RESTRICT="nostrip"

RDEPEND="vorbis? ( media-libs/libvorbis )
	X? ( virtual/x11 )
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
	!=media-libs/xine-lib-0.9.13*"

DEPEND="${RDEPEND}
	v4l? ( sys-kernel/linux-headers )
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.59
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PV}/

	elibtoolize

	# Makefile.ams and configure.ac get patched, so we need to rerun
	# autotools
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	aclocal -I m4 || die "aclocal failed"
	autoheader || die "autoheader failed"
	automake -afc || die "automake failed"
	autoconf || die "autoconf failed"

	libtoolize --copy --force || die "libtoolize failed"
}

src_compile() {
	#filter dangerous compile CFLAGS
	strip-flags

	#prevent quicktime crashing
	append-flags -frename-registers

	use x86 && has_pic && append-flags -UHAVE_MMX

	if [[ "$(gcc-major-version)" -eq "3" && "$(gcc-minor-version)" -ge "4" ]] || [[ "$(gcc-major-version)" -ge "4" ]]; then
		# bugs 49509 and 55202
		append-flags -fno-web -funit-at-a-time
		filter-flags -fno-unit-at-a-time #55202
	fi

	is-flag -O? || append-flags -O1 #31243

	# fix build errors with sse2 #49482
	if [[ $(tc-arch) = "x86" && $(gcc-major-version) -ge 3 ]]; then
		append-flags -mno-sse2 $(test_flag -mno-sse3)
		filter-mfpmath sse
	fi

	local myconf

	# the win32 codec path should ignore $(get_libdir) and always use lib
	use win32codecs \
		&& myconf="${myconf} --with-w32-path=/usr/$(get_libdir)/win32" \
		|| myconf="${myconf} --disable-asf"

	# enable/disable appropiate optimizations on sparc
	[[ "${PROFILE_ARCH}" == "sparc64" ]] \
		&& myconf="${myconf} --enable-vis"
	[[ "${PROFILE_ARCH}" == "sparc" ]] \
		&& myconf="${myconf} --disable-vis"

	# Fix compilation-errors on PowerPC #45393 & #55460 & #68251
	if use ppc || use ppc64 ; then
		append-flags -U__ALTIVEC__
		myconf="${myconf} $(use_enable altivec)"
	fi

	# The default CFLAGS (-O) is the only thing working on hppa.
	if use hppa; then
		unset CFLAGS
	else
		append-flags -ffunction-sections
	fi

	if use xvmc; then
		count="0"
		use nvidia && count="`expr ${count} + 1`"
		use i8x0 && count="`expr ${count} + 1`"
		use cle266 && count="`expr ${count} + 1`"
		if [[ "${count}" -gt "1" ]]; then
			eerror "Invalid combination of USE flags"
			eerror "When building support for xvmc, you may only"
			eerror "include support for one video card:"
			eerror "   nvidia, i8x0, cle266"
			eerror ""
			die "emerge again with different USE flags"
		fi

		use nvidia && xvmclib="XvMCNVIDIA"
		use i8x0 && xvmclib="I810XvmC"
		use cle266 && xvmclib="viaXvMC"

		if [[ -n "${xvmclib}" ]]; then
			if [[ -f "${ROOT}/usr/$(get_libdir)/libXvMC.so" || -f "${ROOT}/usr/$(get_libdir)/libXvMC.a" ]]; then
				myconf="${myconf} --with-xvmc-path=${ROOT}/usr/$(get_libdir) --with-xxmc-path=${ROOT}/usr/$(get_libdir) --with-xvmc-lib=${xvmclib} --with-xxmc-lib=${xvmclib}"
			elif [[ -f "${ROOT}/usr/X11R6/$(get_libdir)/libXvMC.so" || -f "${ROOT}/usr/X11R6/$(get_libdir)/libXvMC.a" ]]; then
				myconf="${myconf} --with-xvmc-path=${ROOT}/usr/X11R6/$(get_libdir) --with-xxmc-path=${ROOT}/usr/X11R6/$(get_libdir) --with-xvmc-lib=${xvmclib} --with-xxmc-lib=${xvmclib}"
			else
				ewarn "Couldn't find libXvMC.  Disabling xvmc support."
			fi
		fi
	fi

	if use xv; then
		if [[ -f "${ROOT}/usr/$(get_libdir)/libXv.so" ]]; then
			myconf="${myconf} --with-xv-path=${ROOT}/usr/$(get_libdir)"
		elif [[ -f "${ROOT}/usr/$(get_libdir)/libXv.a" ]]; then
			myconf="${myconf} --enable-static-xv --with-xv-path=${ROOT}/usr/$(get_libdir)"
		elif [[ -f "${ROOT}/usr/X11R6/$(get_libdir)/libXv.so" ]]; then
			myconf="${myconf} --with-xv-path=${ROOT}/usr/X11R6/$(get_libdir)"
		elif [[ -f "${ROOT}/usr/X11R6/$(get_libdir)/libXv.a" ]]; then
			myconf="${myconf} --enable-static-xv --with-xv-path=${ROOT}/usr/X11R6/$(get_libdir)"
		else
			eerror "Couldn't find your libXv.  Did you set USE=\"xv\" when you emerged xorg-x11?"
			die "Couldn't find libXv."
		fi
	fi

	econf \
		$(use_enable gnome) \
		$(use_enable nls) \
		$(use_enable ipv6) \
		$(use_enable samba) \
		\
		$(use_enable mng) \
		$(use_enable imagemagick) \
		\
		$(use_enable aac faad) \
		$(use_enable flac) \
		$(use_with vorbis ogg) $(use_with vorbis) \
		$(use_enable speex) \
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
		$(use_with a52 external-a52dec) \
		$(use_with mad external-libmad) \
		--disable-polypaudio \
		${myconf} \
		--disable-dependency-tracking || die "econf failed"

		#$(use_with dvdnav external-dvdnav) \
		#$(use_enable macos macosx-video) $(use_enable macos coreaudio) \
		# This will be added when polypaudio will be added to portage.
		# $(use_enable polypaudio)

	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"

	# Xine's makefiles install some file incorrectly. (Gentoo bug #8583, #16112).
	dodir /usr/share/xine/libxine1/fonts
	mv ${D}/usr/share/*.xinefont.gz ${D}/usr/share/xine/libxine1/fonts/

	dodoc AUTHORS ChangeLog README TODO doc/README* doc/faq/faq.txt
	dohtml doc/faq/faq.html doc/hackersguide/*.html doc/hackersguide/*.png

	rm -rf ${D}/usr/share/doc/xine
}

pkg_postinst() {
	einfo
	einfo "Make sure to remove your ~/.xine if upgrading from a pre-1.0 version."
	einfo
}
