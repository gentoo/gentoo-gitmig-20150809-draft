# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-nv/xf86-video-nv-1.2.0.ebuild,v 1.8 2006/10/18 17:04:45 agriffis Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=2

inherit x-modular

DESCRIPTION="NVIDIA video driver"

KEYWORDS="alpha amd64 arm ia64 ~ppc ppc64 sh x86 ~x86-fbsd"

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xproto"
