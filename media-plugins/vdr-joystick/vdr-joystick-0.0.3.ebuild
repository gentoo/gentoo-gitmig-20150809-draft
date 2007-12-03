# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-joystick/vdr-joystick-0.0.3.ebuild,v 1.1 2007/12/03 20:47:01 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: allows using a joystick as a remote control for VDR."
HOMEPAGE="http://www.powarman.de/vdr_plugins.htm"
SRC_URI="http://home.arcor.de/andreas.regel/files/joystick/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/joystick
	doins   "${FILESDIR}"/mapping.conf
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "To use the plugin your joystick has to be connected to your game port and its kernel module has to be loaded."
	elog "Check configuration file:"
	elog "/etc/vdr/plugins/joystick/mapping.conf"
	echo
}
