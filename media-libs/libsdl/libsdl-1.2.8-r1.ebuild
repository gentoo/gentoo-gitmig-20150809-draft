# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.8-r1.ebuild,v 1.19 2005/08/04 03:59:52 vapier Exp $

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org/"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 sparc x86"
# WARNING:
# if you have the noaudio, novideo, nojoystick, or noflagstrip use flags
# in USE and something breaks, you pick up the pieces.  Be prepared for
# bug reports to be marked INVALID.
IUSE="oss alsa esd arts nas X dga xv xinerama fbcon directfb ggi svga aalib opengl libcaca pic noaudio novideo nojoystick noflagstrip"

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

S=${WORKDIR}/SDL-${PV}

pkg_setup() {
	if use noaudio || use novideo || use nojoystick ; then
		ewarn "Since you've chosen to turn off some of libsdl's functionality,"
		ewarn "don't bother filing libsdl-related bugs until trying to remerge"
		ewarn "libsdl without the no* flags in USE.  You need to know what"
		ewarn "you're doing to selectively turn off parts of libsdl."
		epause 30
	fi
	if use noflagstrip ; then
		ewarn "Since you've chosen to use possibly unsafe CFLAGS,"
		ewarn "don't bother filing libsdl-related bugs until trying to remerge"
		ewarn "libsdl without the noflagstrip use flag in USE."
		epause 10
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-nobuggy-X.patch #30089
	epatch "${FILESDIR}"/${P}-libcaca.patch #40224
	epatch "${FILESDIR}"/${PV}-gcc2.patch #75392
	epatch "${FILESDIR}"/${P}-sdl-config.patch
	epatch "${FILESDIR}"/${P}-no-cxx.patch

	# This patch breaks compiling >-O0 on gcc4 ; bug #87809
	[ "`gcc-major-version`" -lt "4" ] && epatch "${FILESDIR}"/${P}-gcc2.patch.bz2 #86481
	epatch "${FILESDIR}"/${PV}-keyrepeat.patch #76448
	epatch "${FILESDIR}"/${PV}-linux26.patch #74608
	#epatch "${FILESDIR}"/${PV}-direct-8bit-color.patch #76946
	epatch "${FILESDIR}"/${PV}-amd64-endian.patch #77300
	#fix for building with gcc4 (within bounds - here I need to
	#build with -O0 to get it done)
	epatch "${FILESDIR}"/${PV}-gcc4.patch

	./autogen.sh || die "autogen failed"
	epunt_cxx
}

src_compile() {
	local myconf=
	if use x86 ; then
		# silly bundled asm triggers TEXTREL ... maybe someday
		# i'll fix this properly, but for now hide with USE=pic
		use pic || myconf="${myconf} $(use_enable x86 nasm)"
	fi
	use noflagstrip || strip-flags
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

	if use ppc-macos ; then
		append-flags -fno-common -undefined dynamic_lookup -framework OpenGL
		# fix for gcc-apple >3.3
		if [ -e libgcc_s.1.dylib ] ; then
			append-ldflags -lgcc_s
		fi
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
