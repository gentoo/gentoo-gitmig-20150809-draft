# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery-plugin/xfce4-battery-plugin-0.5.1.ebuild,v 1.2 2011/01/06 16:20:45 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Battery status panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.5/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/xfce4-panel-4.3.90.2
	>=xfce-base/libxfce4util-4.3.90.2
	>=xfce-base/libxfcegui4-4.3.90.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}/${PV}-freebsd.patch"
		"${FILESDIR}/${PV}-libacpi.patch"
		"${FILESDIR}/${PV}-2.6.24-headers.patch"
		"${FILESDIR}/${PV}-sysfs.patch" )
	DOCS="AUTHORS ChangeLog README"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}
