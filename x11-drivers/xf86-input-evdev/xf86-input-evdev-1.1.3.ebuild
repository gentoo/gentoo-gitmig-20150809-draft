# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-1.1.3.ebuild,v 1.1 2006/10/22 18:07:38 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER=4

inherit x-modular

# The tarball is currently in the wrong place upstream
SRC_URI="${BASE_INDIVIDUAL_URI}/app/${P}.tar.gz
	http://dev.gentoo.org/~joshuabaergen/distfiles/x11-driver-patches-${XDPVER}.tar.bz2"

DESCRIPTION="Generic Linux input driver"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	|| ( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
