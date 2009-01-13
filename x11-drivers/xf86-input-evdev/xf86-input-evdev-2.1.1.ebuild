# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.1.1.ebuild,v 1.1 2009/01/13 03:05:01 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Generic Linux input driver"
KEYWORDS="~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="hal"
RDEPEND=">=x11-base/xorg-server-1.5.3
	hal? ( >=sys-apps/hal-0.5.10 )"
DEPEND="${RDEPEND}
	|| ( >=sys-kernel/linux-headers-2.6 >=sys-kernel/mips-headers-2.6 )
	>=x11-proto/inputproto-1.4
	x11-proto/randrproto
	x11-proto/xproto"

pkg_postinst() {
	x-modular_pkg_postinst
	pkg_info
}

pkg_info() {
	if use hal; then
		elog "If your XKB (keyboard settings) stopped working,"
		elog "you may uninstall this driver or move your XKB configuration."
		elog "Download an example from http://dev.gentoo.org/~compnerd/temp/hal-config-examples/"
		elog "(these will be installed with sys-apps/hal soon),"
		elog "and drop it into /etc/hal/fdi/policy/"
	fi
}
