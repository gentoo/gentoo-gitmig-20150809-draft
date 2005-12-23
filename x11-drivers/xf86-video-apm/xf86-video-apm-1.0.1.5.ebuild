# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-apm/xf86-video-apm-1.0.1.5.ebuild,v 1.1 2005/12/23 20:20:24 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for apm cards"
KEYWORDS="~x86"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86rushproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xproto"
