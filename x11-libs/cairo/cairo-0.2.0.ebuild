# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-0.2.0.ebuild,v 1.3 2004/12/09 04:01:02 weeve Exp $

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="glitz png"

DEPEND="virtual/x11
	|| ( >=x11-base/xfree-4.3.0-r7 x11-base/xorg-x11 )
	virtual/xft
	media-libs/fontconfig
	>=media-libs/freetype-2*
	>=media-libs/libpixman-0.1.1
	glitz? ( media-libs/glitz-cvs )
	png? ( media-libs/libpng )"

src_compile() {
	use glitz && ewarn "Cairo glitz support seems to be broken, expect compilation to fail"
	econf `use_enable glitz` `use_enable png` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
}
