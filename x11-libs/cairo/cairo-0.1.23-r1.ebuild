# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-0.1.23-r1.ebuild,v 1.10 2004/12/09 19:53:31 gustavoz Exp $

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ppc sparc x86"
IUSE=""

DEPEND="virtual/x11
	|| ( >=x11-base/xfree-4.3.0-r7 x11-base/xorg-x11 )
	virtual/xft
	media-libs/fontconfig
	>=media-libs/freetype-2*
	>=media-libs/libpixman-0.1.1"

src_compile() {
	PKG_CONFIG_PATH=${PKG_CONFIG_PATH+$PKG_CONFIG_PATH:}${FILESDIR} econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
}
