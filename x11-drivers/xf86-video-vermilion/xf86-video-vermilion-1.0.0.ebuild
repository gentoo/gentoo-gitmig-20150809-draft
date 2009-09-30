# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vermilion/xf86-video-vermilion-1.0.0.ebuild,v 1.2 2009/09/30 21:21:50 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="Intel Vermilion chipset video driver"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.3.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xproto"
