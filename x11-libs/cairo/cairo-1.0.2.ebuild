# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-1.0.2.ebuild,v 1.14 2006/02/19 16:42:04 geoman Exp $

inherit eutils

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE="doc glitz png X"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2.1
	sys-libs/zlib
	X? ( || ( (	x11-libs/libXrender
			x11-libs/libXt )
			virtual/x11 )
		virtual/xft )
	glitz? ( >=media-libs/glitz-0.4.4 )
	png? ( media-libs/libpng )
	!<x11-libs/cairo-0.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? (	>=dev-util/gtk-doc-1.3
		~app-text/docbook-xml-dtd-4.2 )"


src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Call PKG_PROG_PKG_CONFIG to fix other standard pkg-config calls
	epatch ${FILESDIR}/${P}-pkg_macro.patch

	cp aclocal.m4 old_macros.m4
	aclocal -I . || die "aclocal failed"
	autoconf || die "autoconf failed"
}


src_compile() {
	local myconf="$(use_with X x) \
		$(use_enable X xlib)      \
		$(use_enable png)         \
		$(use_enable doc gtk-doc) \
		$(use_enable glitz)"

	econf $myconf || die "./configure failed"
	emake || die "Compilation failed"
}


src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
