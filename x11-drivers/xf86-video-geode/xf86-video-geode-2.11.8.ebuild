# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-geode/xf86-video-geode-2.11.8.ebuild,v 1.2 2010/06/01 12:37:41 phajdan.jr Exp $

inherit x-modular

DESCRIPTION="AMD Geode GX and LX video driver"

KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.5"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	>=x11-proto/randrproto-1.2
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xproto"
	#>=x11-misc/util-macros-1.4 - only necessary if eautoreconfing
