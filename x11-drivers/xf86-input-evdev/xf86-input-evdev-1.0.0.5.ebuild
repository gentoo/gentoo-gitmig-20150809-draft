# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-1.0.0.5.ebuild,v 1.13 2006/07/19 15:20:15 gmsoft Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for evdev input devices"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc x86"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	|| ( >=sys-kernel/linux-headers-2.6
		>=sys-kernel/mips-headers-2.6 )
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
