# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvkbd/xvkbd-2.6.ebuild,v 1.8 2005/12/28 18:11:08 nelchael Exp $

DESCRIPTION="virtual keyboard for X window system"
HOMEPAGE="http://homepage3.nifty.com/tsato/xvkbd/"
SRC_URI="http://homepage3.nifty.com/tsato/xvkbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="|| ( ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXtst
		)
		virtual/x11
	)
	x11-libs/Xaw3d"

DEPEND="${RDEPEND}
	|| ( ( x11-misc/imake
		x11-proto/xproto
		x11-proto/xextproto
		)
		virtual/x11
	)"

src_compile() {
	xmkmf -a || die
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README
	newman ${PN}.man ${PN}.1
}
