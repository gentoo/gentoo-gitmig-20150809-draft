# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-0.1.23-r1.ebuild,v 1.1 2004/06/27 11:18:40 twp Exp $

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""
DEPEND="virtual/x11
	|| ( >=x11-base/xfree-4.3.0-r6 x11-base/xorg-x11 )
	virtual/xft
	media-libs/fontconfig
	>=media-libs/freetype-2*
	>=media-libs/libpixman-0.1.1"

src_compile() {
	PKG_CONFIG_PATH=${FILESDIR} econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
}
