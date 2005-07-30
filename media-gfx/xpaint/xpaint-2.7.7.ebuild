# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xpaint/xpaint-2.7.7.ebuild,v 1.1 2005/07/30 03:10:16 vanquirius Exp $

inherit eutils

DESCRIPTION="XPaint is an image editor which supports most standard paint program options."
HOMEPAGE="http://sf-xpaint.sourceforge.net/"
SRC_URI="mirror://sourceforge/sf-xpaint/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="Xaw3d"

DEPEND=">=media-libs/tiff-3.2
	virtual/x11
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	sys-devel/bison
	sys-devel/flex
	Xaw3d? ( x11-libs/Xaw3d )"

src_compile() {
	xmkmf -a || die

	if use Xaw3d; then
		make xaw3d || die
	else
		make xaw || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die
}
