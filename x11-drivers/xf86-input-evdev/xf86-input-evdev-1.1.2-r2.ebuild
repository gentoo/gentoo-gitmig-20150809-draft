# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-1.1.2-r2.ebuild,v 1.8 2006/10/18 16:43:44 agriffis Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Generic Linux input driver"

KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ~ppc ppc64 sh sparc x86"

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	|| ( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"

PATCHES="${FILESDIR}/${PV}-CVS-20060520.patch
	${FILESDIR}/${P}-mips-syscalls.patch
	${FILESDIR}/${PV}-absolute-axis-fix.patch"
