# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xpaint/xpaint-2.7.7.ebuild,v 1.2 2006/02/04 09:51:53 nelchael Exp $

inherit eutils

DESCRIPTION="XPaint is an image editor which supports most standard paint program options."
HOMEPAGE="http://sf-xpaint.sourceforge.net/"
SRC_URI="mirror://sourceforge/sf-xpaint/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="Xaw3d"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXp
		!Xaw3d? ( x11-libs/libXaw ) )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-misc/imake
		x11-misc/gccmakedep
		app-text/rman )
	virtual/x11 )
	>=media-libs/tiff-3.2
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
