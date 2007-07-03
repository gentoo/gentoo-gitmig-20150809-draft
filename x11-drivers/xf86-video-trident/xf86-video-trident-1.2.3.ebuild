# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-trident/xf86-video-trident-1.2.3.ebuild,v 1.6 2007/07/03 13:14:39 pylon Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=3

inherit x-modular

DESCRIPTION="Trident video driver"
KEYWORDS="amd64 arm ia64 ppc sh x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xproto"
