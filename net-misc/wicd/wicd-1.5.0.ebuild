# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wicd/wicd-1.5.0.ebuild,v 1.1 2008/08/03 02:52:19 darkside Exp $

inherit distutils

DESCRIPTION="A lightweight wired and wireless network manager for Linux"
HOMEPAGE="http://wicd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	dev-python/pygtk
	|| (
		net-misc/dhcp
		net-misc/dhcpcd
		net-misc/pump
	)
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	|| (
		sys-apps/ethtool
		sys-apps/net-tools
	)"

src_compile() {
	${python} ./setup.py configure --no-install-init --resume=/usr/share/wicd/scripts/ --suspend=/usr/share/wicd/scripts/ --verbose
	distutils_src_compile
}

src_install() {
	distutils_src_install
	newinitd "${FILESDIR}/${P}-init.d" wicd || die "newinitd failed"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "Note: commands have changed since previous versions of WICD"
	elog "Start the WICD GUI using:"
	elog "    /usr/bin/wicd-client"
	einfo
	elog "You may need to restart the dbus service after upgrading wicd."
}
