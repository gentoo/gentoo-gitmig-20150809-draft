# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvkbd/xvkbd-2.6.ebuild,v 1.10 2006/07/10 17:51:12 flameeyes Exp $

DESCRIPTION="virtual keyboard for X window system"
HOMEPAGE="http://homepage3.nifty.com/tsato/xvkbd/"
SRC_URI="http://homepage3.nifty.com/tsato/xvkbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="|| ( (
			x11-libs/libXtst
			x11-libs/libXmu
		) <virtual/x11-7 )
	x11-libs/Xaw3d"

DEPEND="${RDEPEND}
	|| ( ( x11-misc/imake
		x11-proto/xproto
		app-text/rman
		x11-proto/xextproto
		)
		<virtual/x11-7
	)"

pkg_setup() {
	has_version '<x11-base/xorg-x11-7' && \
		appdefaultsdir="/etc/X11/app-defaults/" || \
		appdefaultsdir="/usr/share/X11/app-defaults/"
}

src_compile() {
	xmkmf -a || die

	emake \
		XAPPLOADDIR="${appdefaultsdir}" \
		LOCAL_LDFLAGS="${LDFLAGS}" \
		CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake XAPPLOADDIR="${appdefaultsdir}" DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}/usr/lib/X11"

	dodoc README
	newman ${PN}.man ${PN}.1
}
