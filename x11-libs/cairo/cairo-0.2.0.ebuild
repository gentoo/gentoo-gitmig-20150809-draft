# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-0.2.0.ebuild,v 1.8 2005/02/06 17:49:39 corsair Exp $

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~ppc64"
IUSE="glitz png"

DEPEND="virtual/x11
	|| ( >=x11-base/xfree-4.3.0-r7 x11-base/xorg-x11 )
	virtual/xft
	media-libs/fontconfig
	>=media-libs/freetype-2*
	>=media-libs/libpixman-0.1.2
	glitz? ( =media-libs/glitz-0.2.3 )
	png? ( media-libs/libpng )"

src_compile() {
	econf \
		$(use_enable glitz) \
		$(use_enable png) \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
}
