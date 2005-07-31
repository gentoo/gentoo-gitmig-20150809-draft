# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-0.6.0.ebuild,v 1.4 2005/07/31 13:55:21 foser Exp $

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="glitz png X"

RDEPEND="X? (
			virtual/x11
			virtual/xft
		)
		media-libs/fontconfig
		>=media-libs/freetype-2
		>=media-libs/libpixman-0.1.5
		png? ( media-libs/libpng )
	!<x11-libs/cairo-0.2"
# the block fixes the issue described in #85285 without patching

# no snapshot available yet
#		glitz? ( >=media-libs/glitz-0.4.4 )

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {

	econf \
		$(use_enable X xlib) \
		$(use_enable png) \
		|| die
#		$(use_enable glitz) \

	emake || die

}


src_install() {

	make install DESTDIR="${D}" || die

}
