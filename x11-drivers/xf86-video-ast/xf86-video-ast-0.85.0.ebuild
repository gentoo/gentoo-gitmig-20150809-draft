# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ast/xf86-video-ast-0.85.0.ebuild,v 1.3 2008/09/24 13:37:39 aballier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=-1

inherit x-modular

DESCRIPTION="X.Org driver for ASpeedTech cards"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
LICENSE="MIT"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xproto"
