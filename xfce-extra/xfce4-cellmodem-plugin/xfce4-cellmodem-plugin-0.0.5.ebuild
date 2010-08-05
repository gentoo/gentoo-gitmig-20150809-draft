# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cellmodem-plugin/xfce4-cellmodem-plugin-0.0.5.ebuild,v 1.2 2010/08/05 23:13:58 ssuominen Exp $

EAUTORECONF=yes
EINTLTOOLIZE=yes
EAPI=2
inherit xfconf

DESCRIPTION="Panel plugin for monitoring cellular modems - GPRS/UMTS(3G)/HSDPA(3.5G)"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.0/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=xfce-base/xfce4-panel-4.3.20
	>=xfce-base/libxfcegui4-4.3.20
	sys-apps/pciutils[zlib]
	=virtual/libusb-0*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-asneeded.patch
		"${FILESDIR}"/${P}-link_for_xfce_warn.patch
		)

	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog README"
}

src_prepare() {
	echo panel-plugin/cellmodem.desktop.in.in >> po/POTFILES.skip
	xfconf_src_prepare
}
