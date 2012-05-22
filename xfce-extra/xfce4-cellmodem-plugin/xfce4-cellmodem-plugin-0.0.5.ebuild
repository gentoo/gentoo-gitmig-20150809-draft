# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cellmodem-plugin/xfce4-cellmodem-plugin-0.0.5.ebuild,v 1.7 2012/05/22 10:54:08 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
inherit multilib xfconf

DESCRIPTION="A panel plug-in with monitoring support for GPRS/UMTS(3G)/HSDPA(3.5G) modems"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-cellmodem-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="sys-apps/pciutils[zlib]
	virtual/libusb:0
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-asneeded.patch
		"${FILESDIR}"/${P}-link_for_xfce_warn.patch
		)

	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		$(use_enable debug)
		)

	DOCS=( AUTHORS ChangeLog README )
}

src_prepare() {
	echo panel-plugin/cellmodem.desktop.in.in > po/POTFILES.skip
	xfconf_src_prepare
}
