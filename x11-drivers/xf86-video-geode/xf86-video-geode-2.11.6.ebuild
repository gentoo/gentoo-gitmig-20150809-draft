# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-geode/xf86-video-geode-2.11.6.ebuild,v 1.1 2009/11/03 09:29:27 remi Exp $

inherit x-modular

DESCRIPTION="AMD Geode GX and LX video driver"

KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.5"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	>=x11-proto/randrproto-1.2
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xproto"
