# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wavelan-plugin/xfce4-wavelan-plugin-0.5.5.ebuild,v 1.8 2011/01/29 20:59:04 ssuominen Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Wireless monitor panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-wavelan-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.5/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 x86"
IUSE="debug"

RDEPEND=">=xfce-base/xfce4-panel-4.3.20
	>=xfce-base/libxfcegui4-4.3.20
	>=xfce-base/libxfce4util-4.3.20
	>=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README THANKS"
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)
	PATCHES=( "${FILESDIR}"/${P}-libs_for_xfce_create_header.patch )
}
