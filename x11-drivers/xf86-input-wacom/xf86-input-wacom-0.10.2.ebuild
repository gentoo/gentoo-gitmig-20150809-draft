# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-wacom/xf86-input-wacom-0.10.2.ebuild,v 1.2 2009/12/10 08:51:37 zmedico Exp $

EAPI="2"

inherit linux-info x-modular

DESCRIPTION="Driver for Wacom tablets and drawing devices"
LICENSE="GPL-2"
EGIT_REPO_URI="git://anongit.freedesktop.org/~whot/xf86-input-wacom"
[[ ${PV} != 9999* ]] && \
	SRC_URI="http://people.freedesktop.org/~whot/${PN}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="hal debug"

COMMON_DEPEND=">=x11-base/xorg-server-1.6
	hal? ( sys-apps/hal )"
RDEPEND="${COMMON_DEPEND}
	!x11-drivers/linuxwacom"
DEPEND="${COMMON_DEPEND}
	x11-proto/inputproto
	x11-proto/xproto"

pkg_setup() {
	linux-info_pkg_setup

	CONFIGURE_OPTIONS="$(use_enable debug)"
}

src_install() {
	x-modular_src_install

	if use hal; then
		insinto /usr/share/hal/fdi/policy/10osvendor
		newins "${S}"/fdi/wacom.fdi 11-x11-wacom.fdi
	fi
}

pkg_postinst() {
	x-modular_pkg_postinst

	if ! linux_chkconfig_present TABLET_USB_WACOM \
	|| ! linux_chkconfig_present INPUT_EVDEV; then
		echo
		ewarn "If you use a USB Wacom tablet, you need to enable support in your kernel"
		ewarn "  Device Drivers --->"
		ewarn "    Input device support --->"
		ewarn "      <*>   Event interface"
		ewarn "      [*]   Tablets  --->"
		ewarn "        <*>   Wacom Intuos/Graphire tablet support (USB)"
		echo
	fi
}
