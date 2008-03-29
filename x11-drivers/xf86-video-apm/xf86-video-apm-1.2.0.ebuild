# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-apm/xf86-video-apm-1.2.0.ebuild,v 1.2 2008/03/29 19:35:24 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="Alliance ProMotion video driver"
KEYWORDS="~amd64 ~ia64 ~sh ~x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86rushproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xproto"
