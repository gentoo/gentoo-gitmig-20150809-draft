# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/links/links-2.4-r1.ebuild,v 1.5 2011/11/25 00:52:38 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A fast and lightweight web browser running in both graphics and text mode"
HOMEPAGE="http://links.twibright.com/"
SRC_URI="http://${PN}.twibright.com/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="bzip2 directfb fbcon gpm jpeg livecd ssl suid svga tiff unicode X zlib"

# Note: if X or fbcon usegflag are enabled, links will be built in graphic
# mode. libpng is required to compile links in graphic mode
# (not required in text mode), so let's add libpng for X? and fbcon?

# We've also made USE=livecd compile in graphics mode.  This closes bug #75685.

# 2.3_pre1: SDL support is disabled in this version by upstream: sdl? ( >=media-libs/libsdl-1.2.0 )
RDEPEND="ssl? ( dev-libs/openssl:0 )
	gpm? ( sys-libs/gpm )
	jpeg? ( virtual/jpeg )
	fbcon? (
		media-libs/libpng:0
		virtual/jpeg
		sys-libs/gpm
		)
	tiff? ( media-libs/tiff:0 )
	svga? (
		>=media-libs/svgalib-1.4.3
		media-libs/libpng:0
		)
	X? (
		x11-libs/libXext
		media-libs/libpng:0
		)
	directfb? ( dev-libs/DirectFB )
	sys-libs/ncurses
	livecd? (
		media-libs/libpng:0
		virtual/jpeg
		sys-libs/gpm
		)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

REQUIRED_USE="svga? ( suid )"

DOCS=( AUTHORS BRAILLE_HOWTO BUGS ChangeLog KEYS NEWS README SITES TODO )

src_prepare() {
	if use unicode; then
		pushd intl >/dev/null
		./gen-intl || die
		./synclang || die
		popd >/dev/null
	fi

	# Upstream configure produced by broken autoconf-2.13.  See #131440 and
	# #103483#c23.  This also fixes toolchain detection.
	eautoconf
}

src_configure() {
	local myconf

	if use X || use fbcon || use directfb || use svga || use livecd; then
		myconf="${myconf} --enable-graphics"
	fi

	# Note: --enable-static breaks.

	# Note: ./configure only support 'gpm' features auto-detection, so
	# we use the autoconf trick
	( use gpm || use fbcon || use livecd ) || export ac_cv_lib_gpm_Gpm_Open=no

	if use fbcon || use livecd; then
		myconf="${myconf} --with-fb"
	else
		myconf="${myconf} --without-fb"
	fi

	# force --with-libjpeg if livecd flag is set
	if use livecd; then
		myconf="${myconf} --with-libjpeg"
	fi

	# $(use_with sdl)
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
	default

	if use X; then
		newicon Links_logo.png ${PN}.png
		make_desktop_entry "${PN} -g" Links ${PN} "Network;WebBrowser"
	fi

	dohtml doc/links_cal/*

	dosym links /usr/bin/links2

	use suid && fperms 4755 /usr/bin/links
}
