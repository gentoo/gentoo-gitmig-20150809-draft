# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-1.0.4-r1.ebuild,v 1.3 2006/10/20 13:27:12 agriffis Exp $

inherit eutils

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ~ppc ~ppc-macos ~ppc64 s390 sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc glitz png X"
# bug 118106: not entirely broken, just too flakey
RESTRICT="test"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2.1
	X? ( || ( (	x11-libs/libXrender
			x11-libs/libX11 )
			virtual/x11 )
		virtual/xft )
	glitz? ( =media-libs/glitz-0.4.4* )
	png? ( media-libs/libpng )
	!<x11-libs/cairo-0.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	X? ( || ( x11-proto/renderproto virtual/x11 ) )
	doc? (	>=dev-util/gtk-doc-1.3
		~app-text/docbook-xml-dtd-4.2 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/${P}-ssp-nonsense.patch #109480
}

src_compile() {

	econf $(use_enable X xlib) \
		$(use_enable png) \
		$(use_enable doc gtk-doc) \
		$(use_enable glitz) \
		--enable-freetype || die "./configure failed"

	emake || die "Compilation failed"

}

src_install() {

	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO

}
