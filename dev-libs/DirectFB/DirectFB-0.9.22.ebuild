# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.22.ebuild,v 1.3 2005/04/15 03:57:43 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

IUSE_VIDEO_CARDS="ati128 cle266 cyber5k i810 mach64 matrox neomagic nsc nvidia radeon savage sis315 tdfx unichrome"

DESCRIPTION="Thin library on top of the Linux framebuffer devices"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 -mips ppc -sparc x86"
IUSE="debug fbcon fusion gif jpeg mmx mpeg png sdl sse static sysfs truetype"

DEPEND="sdl? ( media-libs/libsdl )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	mpeg? ( media-libs/libmpeg3 )
	sysfs? ( sys-fs/sysfsutils )
	truetype? ( >=media-libs/freetype-2.0.1 )"

pkg_setup() {
	if [[ -z ${VIDEO_CARDS} ]] ; then
		ewarn "All video drivers will be built since you did not specify"
		ewarn "via the VIDEO_CARDS variable what video card you use."
		einfo "DirectFB supports: ${IUSE_VIDEO_CARDS} all none"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Make sure i830 is detected
	# force disable wm97xx #36924
	sed -i \
		-e 's:^//::' \
		-e 's:wm97xx_ts=yes:wm97xx_ts=no:' \
		configure \
		|| die "sed configure failed"

	# This patch enables simd optimisations for amd64. Since mmx and sse are
	# masked USE flags on amd64 due to their enabling x86 specific asm more
	# often than not, we'll just enable them by default. All x86_64 cpus
	# should support mmx and see. Travis Tilley <lv@gentoo.org>
	use amd64 && epatch "${FILESDIR}"/0.9.21-simd-amd64.patch
}

src_compile() {
	local vidcards card
	for card in ${VIDEO_CARDS} ; do
		has ${card} ${IUSE_VIDEO_CARDS} && vidcards="${vidcards},${card}"
	done
	[[ -z ${vidcards} ]] \
		&& vidcards="all" \
		|| vidcards="${vidcards:1}"

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
		${sdlconf} \
		--with-gfxdrivers="${vidcards}" \
		|| die
	emake || die
}

src_install() {
	insinto /etc
	doins fb.modes

	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README* TODO
	dohtml -r docs/html/*
}

pkg_postinst() {
	ewarn "Each DirectFB update in the 0.9.xx series"
	ewarn "breaks DirectFB related applications."
	ewarn "Please run \"revdep-rebuild\" which can be"
	ewarn "found by emerging the package 'gentoolkit'."
}
