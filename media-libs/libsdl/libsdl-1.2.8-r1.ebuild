# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.8-r1.ebuild,v 1.6 2005/04/02 01:00:46 vapier Exp $

inherit flag-o-matic toolchain-funcs eutils gnuconfig

DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org/"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="oss alsa esd arts nas X dga xv xinerama fbcon directfb ggi svga aalib opengl libcaca noaudio novideo nojoystick"
# if you disable audio/video/joystick and something breaks, you pick up the pieces

RDEPEND=">=media-libs/audiofile-0.1.9
	alsa? ( media-libs/alsa-lib )
	esd? ( >=media-sound/esound-0.2.19 )
	arts? ( kde-base/arts )
	nas? ( media-libs/nas
		virtual/x11 )
	X? ( virtual/x11 )
	directfb? ( >=dev-libs/DirectFB-0.9.19 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	svga? ( >=media-libs/svgalib-1.4.2 )
	aalib? ( media-libs/aalib )
	libcaca? ( >=media-libs/libcaca-0.9-r1 )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/SDL-${PV}"

pkg_setup() {
	if use noaudio || use novideo || use nojoystick ; then
		ewarn "Since you've chosen to turn off some of libsdl's functionality,"
		ewarn "don't bother filing libsdl-related bugs until trying to remerge"
		ewarn "libsdl without the no* flags in USE.  You need to know what"
		ewarn "you're doing to selectively turn off parts of libsdl."
		epause 30
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-nobuggy-X.patch #30089
	epatch "${FILESDIR}"/${PV}-libcaca.patch #40224
	epatch "${FILESDIR}"/${PV}-gcc2.patch #75392
	epatch "${FILESDIR}"/${P}-gcc2.patch.bz2 #86481
	epatch "${FILESDIR}"/${PV}-keyrepeat.patch #76448
	epatch "${FILESDIR}"/${PV}-linux26.patch #74608
	#epatch "${FILESDIR}"/${PV}-direct-8bit-color.patch #76946
	epatch "${FILESDIR}"/${PV}-amd64-endian.patch #77300

	if use nas && ! use X ; then #32447
		sed -i \
			-e 's:-laudio:-laudio -L/usr/X11R6/lib:' \
			configure.in || die "nas sed hack failed"
	fi

	./autogen.sh || die "autogen failed"
	epunt_cxx
	gnuconfig_update
}

src_compile() {
	local myconf=

	if use amd64 ; then
		replace-flags -O? -O1 # bug #74608
		strip-flags -funroll-all-loops -fpeel-loops -fomit-frame-pointer # more bug #74608 and also bug #82618
	fi
	if use x86 ; then
		filter-flags -fforce-addr #87077
	fi
	use noaudio && myconf="${myconf} --disable-audio"
	use novideo \
		&& myconf="${myconf} --disable-video" \
		|| myconf="${myconf} --enable-video-dummy"
	use nojoystick && myconf="${myconf} --disable-joystick"

	local directfbconf="--disable-video-directfb"
	if use directfb ; then
		# since DirectFB can link against SDL and trigger a
		# dependency loop, only link against DirectFB if it
		# isn't broken #61592
		echo 'int main(){}' > directfb-test.c
		$(tc-getCC) directfb-test.c -ldirectfb 2>/dev/null \
			&& directfbconf="--enable-video-directfb" \
			|| ewarn "Disabling DirectFB since libdirectfb.so is broken"
	fi
	myconf="${myconf} ${directfbconf}"

	econf \
		--disable-dependency-tracking \
		--enable-events \
		--enable-cdrom \
		--enable-threads \
		--enable-timers \
		--enable-endian \
		--enable-file \
		--enable-cpuinfo \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable esd) \
		$(use_enable arts) \
		$(use_enable nas) \
		$(use_enable x86 nasm) \
		$(use_enable X video-x11) \
		$(use_enable dga) \
		$(use_enable xv video-x11-xv) \
		$(use_enable xinerama video-x11-xinerama) \
		$(use_enable dga video-dga) \
		$(use_enable fbcon video-fbcon) \
		$(use_enable ggi video-ggi) \
		$(use_enable svga video-svga) \
		$(use_enable aalib video-aalib) \
		$(use_enable libcaca video-caca) \
		$(use_enable opengl video-opengl) \
		$(use_with X x) \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	preplib
	# Bug 34804; $(get_libdir) fixed BUG #65495
	sed -i \
		-e "s:-pthread::g" "${D}/usr/$(get_libdir)/libSDL.la" \
		|| die "sed failed"
	dodoc BUGS CREDITS README README-SDL.txt README.CVS TODO WhatsNew
	dohtml -r ./
}
