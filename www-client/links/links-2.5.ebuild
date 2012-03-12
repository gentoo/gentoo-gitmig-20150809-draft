# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/links/links-2.5.ebuild,v 1.11 2012/03/12 19:11:51 maekke Exp $

EAPI=4
inherit autotools eutils fdo-mime

DESCRIPTION="A fast and lightweight web browser running in both graphics and text mode"
HOMEPAGE="http://links.twibright.com/"
SRC_URI="http://${PN}.twibright.com/download/${P}.tar.bz2
	mirror://debian/pool/main/l/${PN}2/${PN}2_${PV}-1.debian.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="bzip2 directfb fbcon gpm jpeg livecd lzma ssl suid svga tiff unicode X zlib"

# Note: if X or fbcon usegflag are enabled, links will be built in graphic
# mode. libpng is required to compile links in graphic mode
# (not required in text mode), so let's add libpng for X? and fbcon?

# We've also made USE=livecd compile in graphics mode.  This closes bug #75685.
PNG_DEPEND=">=media-libs/libpng-1.2:0"

RDEPEND=">=sys-libs/ncurses-5.7-r7
	bzip2? ( app-arch/bzip2 )
	directfb? ( dev-libs/DirectFB )
	fbcon? ( ${PNG_DEPEND} )
	gpm? ( sys-libs/gpm )
	jpeg? ( virtual/jpeg )
	livecd? ( ${PNG_DEPEND} )
	lzma? ( app-arch/xz-utils )
	ssl? ( dev-libs/openssl:0 )
	svga? (
		${PNG_DEPEND}
		>=media-libs/svgalib-1.4.3
		)
	tiff? ( media-libs/tiff:0 )
	X? (
		${PNG_DEPEND}
		x11-libs/libXext
		)
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

REQUIRED_USE="fbcon? ( jpeg gpm )
	livecd? ( jpeg gpm )
	svga? ( suid )"

DOCS=( AUTHORS BRAILLE_HOWTO BUGS ChangeLog KEYS NEWS README SITES TODO )

src_prepare() {
	epatch "${WORKDIR}"/debian/patches/{verify-ssl-certs-510417,ipv6}.diff

	if use unicode; then
		pushd intl >/dev/null
		./gen-intl || die
		./synclang || die
		popd >/dev/null
	fi

	# error: conditional "am__fastdepCXX" was never defined (for eautoreconf)
	sed -i -e '/AC_PROG_CXX/s:#::' configure.in || die

	# Upstream configure produced by broken autoconf-2.13.  See #131440 and
	# #103483#c23.  This also fixes toolchain detection.
	eautoreconf
}

src_configure() {
	export ac_cv_lib_gpm_Gpm_Open=$(usex gpm)

	local myconf

	if use X || use fbcon || use directfb || use svga || use livecd; then
		myconf="${myconf} --enable-graphics"
	fi

	if use fbcon || use livecd; then
		myconf="${myconf} --with-fb"
	else
		myconf="${myconf} --without-fb"
	fi

	econf \
		$(use_with ssl) \
		$(use_with zlib) \
		$(use_with bzip2) \
		$(use_with lzma) \
		$(use_with svga svgalib) \
		$(use_with X x) \
		$(use_with directfb) \
		$(use_with jpeg libjpeg) \
		$(use_with tiff libtiff) \
		${myconf}
}

src_install() {
	default

	if use X; then
		newicon Links_logo.png ${PN}.png
		make_desktop_entry "${PN} -g" Links ${PN} 'Network;WebBrowser'
		echo 'MimeType=x-scheme-handler/http;x-scheme-handler/https;' \
			>> "${ED}"usr/share/applications/*.desktop
	fi

	dohtml doc/links_cal/*

	dosym links /usr/bin/links2

	use suid && fperms 4755 /usr/bin/links
}

pkg_postinst() {
	use X && fdo-mime_desktop_database_update
}

pkg_postrm() {
	use X && fdo-mime_desktop_database_update
}
