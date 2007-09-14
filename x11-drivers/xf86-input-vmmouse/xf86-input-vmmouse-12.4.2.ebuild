# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-vmmouse/xf86-input-vmmouse-12.4.2.ebuild,v 1.1 2007/09/14 09:17:41 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="VMWare mouse input driver"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-0.99.3"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-1.4.1
	x11-proto/randrproto
	x11-proto/xproto"
