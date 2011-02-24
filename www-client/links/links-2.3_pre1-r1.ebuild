# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/links/links-2.3_pre1-r1.ebuild,v 1.5 2011/02/24 21:14:15 tomka Exp $

# SDL support is disabled in this version by upstream

EAPI="2"

inherit eutils autotools

# To handle pre-version ...
MY_P="${P/_/}"
DESCRIPTION="links is a fast lightweight text and graphic web-browser"
HOMEPAGE="http://links.twibright.com/"
SRC_URI="http://links.twibright.com/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="bzip2 directfb fbcon gpm jpeg livecd ssl svga tiff unicode X zlib"

# Note: if X or fbcon usegflag are enabled, links will be built in graphic
# mode. libpng is required to compile links in graphic mode
# (not required in text mode), so let's add libpng for X? and fbcon?

# We've also made USE=livecd compile in graphics mode.  This closes bug #75685.

#	sdl? ( >=media-libs/libsdl-1.2.0 )
RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6c )
	gpm? ( sys-libs/gpm )
	jpeg? ( virtual/jpeg )
	fbcon? (
		>=media-libs/libpng-1.4
		virtual/jpeg
		sys-libs/gpm
	)
	tiff? ( >=media-libs/tiff-3.5.7 )
	svga? (
		>=media-libs/svgalib-1.4.3
		>=media-libs/libpng-1.4
	)
	X? (
		x11-libs/libXext
		>=media-libs/libpng-1.4
	)
	directfb? ( dev-libs/DirectFB )
	sys-libs/ncurses
	livecd? (
		>=media-libs/libpng-1.4
		virtual/jpeg
		sys-libs/gpm
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng-1.5.patch
	epatch "${FILESDIR}"/${P}-verify-ssl-certs.patch #253847

	if use unicode ; then
		pushd intl >/dev/null
		./gen-intl || die
		./synclang || die
		popd >/dev/null
	fi

	# Upstream configure produced by broken autoconf-2.13.  See #131440 and
	# #103483#c23.  This also fixes toolchain detection.
	eautoconf || die
}

src_configure() {
	local myconf

	if use X || use fbcon || use directfb || use svga || use livecd ; then
		myconf="${myconf} --enable-graphics"
	fi

	# Note: --enable-static breaks.

	# Note: ./configure only support 'gpm' features auto-detection, so
	# we use the autoconf trick
	( use gpm || use fbcon || use livecd ) || export ac_cv_lib_gpm_Gpm_Open="no"

	if use fbcon || use livecd ; then
		myconf="${myconf} --with-fb"
	else
		myconf="${myconf} --without-fb"
	fi

	# force --with-libjpeg if livecd flag is set
	if use livecd ; then
		myconf="${myconf} --with-libjpeg"
	fi

	#	$(use_with sdl)
	econf \
		$(use_with X x) \
		$(use_with jpeg libjpeg) \
		$(use_with tiff libtiff) \
		$(use_with svga svgalib) \
		$(use_with directfb) \
		$(use_with ssl) \
		$(use_with zlib) \
		$(use_with bzip2) \
		${myconf}
}

src_install() {
	emake install DESTDIR="${D}" || die

	# Only install links icon if X driver was compiled in ...
	use X && doicon graphics/links.xpm

	dodoc AUTHORS BUGS ChangeLog NEWS README SITES TODO
	dohtml doc/links_cal/*

	# Install a compatibility symlink links2:
	dosym links /usr/bin/links2
}

pkg_postinst() {
	if use svga ; then
		elog "You had the svga USE flag enabled, but for security reasons"
		elog "the links2 binary is NOT setuid by default. In order to"
		elog "enable links2 to work in SVGA, please change the permissions"
		elog "of /usr/bin/links2 to enable suid."
	fi
}
