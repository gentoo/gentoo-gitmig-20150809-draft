# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-1.2.0.ebuild,v 1.4 2008/01/10 18:11:27 jer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

DESCRIPTION="Generic Linux input driver"

KEYWORDS="~amd64 ~hppa ~x86"

RDEPEND=">=x11-base/xorg-server-1.4"
DEPEND="${RDEPEND}
	|| ( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	>=x11-proto/inputproto-1.4
	x11-proto/randrproto
	x11-proto/xproto"
