# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-0.4.0.ebuild,v 1.1 2005/04/11 20:48:08 latexer Exp $

inherit eutils

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~ppc64"
IUSE="glitz png X"

DEPEND="X? (
			virtual/x11
			virtual/xft
			|| ( >=x11-base/xfree-4.3.0-r7 x11-base/xorg-x11 )
		)
		media-libs/fontconfig
		>=media-libs/freetype-2*
		>=media-libs/libpixman-0.1.4
		glitz? ( =media-libs/glitz-0.4.0* )
		png? ( media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
}

src_compile() {
	econf \
		$(use_enable X xlib) \
		$(use_enable glitz) \
		$(use_enable png) \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
}
