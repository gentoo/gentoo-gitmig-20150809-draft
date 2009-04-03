# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-xgi/xf86-video-xgi-1.5.0.ebuild,v 1.4 2009/04/03 14:28:41 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="XGI video driver"
KEYWORDS="ppc ppc64 ~x86"
RDEPEND=">=x11-base/xorg-server-1.0.99"
SRC_URI="${SRC_URI}
		 mirror://gentoo/${P}-bigendian.patch"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}/${P}-bigendian.patch"
}
