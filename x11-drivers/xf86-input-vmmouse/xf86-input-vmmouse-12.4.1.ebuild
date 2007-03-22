# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-vmmouse/xf86-input-vmmouse-12.4.1.ebuild,v 1.1 2007/03/22 02:25:30 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=2

inherit x-modular

DESCRIPTION="VMWare mouse input driver"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-0.99.3"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
