# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.24.ebuild,v 1.10 2006/10/20 00:10:23 kloeri Exp $

inherit eutils flag-o-matic toolchain-funcs

IUSE_VIDEO_CARDS="ati128 cle266 cyber5k i810 i830 mach64 matrox neomagic nsc nvidia radeon r200 savage sis315 tdfx unichrome"
IUSE_INPUT_DEVICES="dbox2remote elo-input h3600_ts joystick keyboard dreamboxremote linuxinput lirc mutouch ps2mouse serialmouse sonypijogdial wm97xx"

DESCRIPTION="Thin library on top of the Linux framebuffer devices"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 -mips ppc sh -sparc x86"
IUSE="debug fbcon fusion gif jpeg mmx mpeg png sdl sse static sysfs truetype zlib"

DEPEND="sdl? ( media-libs/libsdl )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	mpeg? ( media-libs/libmpeg3 )
	sysfs? ( sys-fs/sysfsutils )
	zlib? ( sys-libs/zlib )
	truetype? ( >=media-libs/freetype-2.0.1 )"

pkg_setup() {
	if [[ -z ${VIDEO_CARDS} ]] ; then
		ewarn "All video drivers will be built since you did not specify"
		ewarn "via the VIDEO_CARDS variable what video card you use."
		einfo "DirectFB supports: ${IUSE_VIDEO_CARDS} all none"
		echo
	fi
	if [[ -z ${INPUT_DEVICES} ]] ; then
		ewarn "All input drivers will be built since you did not specify"
		ewarn "via the INPUT_DEVICES variable which input drivers to use."
		einfo "DirectFB supports: ${IUSE_INPUT_DEVICES} all none"
		echo
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-CFLAGS.patch
}

src_compile() {
	# force disable wm97xx #36924
#	export ac_cv_header_linux_wm97xx_h=no
	# force disable of sis315 #77391
#	export ac_cv_header_linux_sisfb_h=no

	local vidcards card input inputdrivers
	for card in ${VIDEO_CARDS} ; do
		has ${card} ${IUSE_VIDEO_CARDS} && vidcards="${vidcards},${card}"
	done
	[[ -z ${vidcards} ]] \
		&& vidcards="all" \
		|| vidcards=${vidcards:1}
	for input in ${INPUT_DEVICES} ; do
		has ${input} ${IUSE_INPUT_DEVICES} && inputdrivers="${inputdrivers},${input}"
	done
	[[ -z ${inputdrivers} ]] \
		&& inputdrivers="all" \
		|| inputdrivers=${inputdrivers:1}

	local sdlconf="--disable-sdl"
	if use sdl ; then
		# since SDL can link against DirectFB and trigger a
		# dependency loop, only link against SDL if it isn't
		# broken #61592
		echo 'int main(){}' > sdl-test.c
		$(tc-getCC) sdl-test.c -lSDL 2>/dev/null \
			&& sdlconf="--enable-sdl" \
			|| ewarn "Disabling SDL since libSDL.so is broken"
	fi

	use mpeg && export CPPFLAGS="${CPPFLAGS} -I/usr/include/libmpeg3"
	econf \
		$(use_enable fbcon fbdev) \
		$(use_enable mmx) \
		$(use_enable sse) \
		$(use_enable mpeg libmpeg3) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable gif) \
		$(use_enable truetype freetype) \
		$(use_enable fusion multi) \
		$(use_enable debug) \
		$(use_enable static) \
		$(use_enable sysfs) \
		$(use_enable zlib) \
		${sdlconf} \
		--with-gfxdrivers="${vidcards}" \
		--with-inputdrivers="${inputdrivers}" \
		--disable-vnc \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc fb.modes AUTHORS ChangeLog NEWS README* TODO
	dohtml -r docs/html/*
}

pkg_postinst() {
	ewarn "Each DirectFB update in the 0.9.xx series"
	ewarn "breaks DirectFB related applications."
	ewarn "Please run \"revdep-rebuild\" which can be"
	ewarn "found by emerging the package 'gentoolkit'."
	ewarn
	ewarn "If you have an ALPS touchpad, then you might"
	ewarn "get your mouse unexpectedly set in absolute"
	ewarn "mode in all DirectFB applications."
	ewarn "This can be fixed by removing linuxinput from"
	ewarn "INPUT_DEVICES."
}
