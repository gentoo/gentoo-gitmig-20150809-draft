# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvkbd/xvkbd-2.6.ebuild,v 1.14 2008/01/09 08:04:49 nelchael Exp $

DESCRIPTION="virtual keyboard for X window system"
HOMEPAGE="http://homepage3.nifty.com/tsato/xvkbd/"
SRC_URI="http://homepage3.nifty.com/tsato/xvkbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libXtst
	x11-libs/libXmu
	x11-libs/libXaw
	x11-libs/Xaw3d"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-misc/gccmakedep
	x11-proto/xproto
	x11-proto/inputproto
	app-text/rman
	x11-proto/xextproto"

src_compile() {
	xmkmf -a || die "xmkmf failed."

	emake \
		XAPPLOADDIR="/usr/share/X11/app-defaults" \
		LOCAL_LDFLAGS="${LDFLAGS}" \
		CDEBUGFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	emake XAPPLOADDIR="/usr/share/X11/app-defaults" DESTDIR="${D}" install \
	|| die "emake install failed."
	rm -rf "${D}/usr/lib/X11"

	dodoc README
	newman ${PN}.man ${PN}.1
}
