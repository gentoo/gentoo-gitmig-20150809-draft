# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wavelan-plugin/xfce4-wavelan-plugin-0.5.6.ebuild,v 1.6 2011/03/29 13:17:08 jer Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Wireless monitor panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-wavelan-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.5/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 x86"
IUSE=""

RDEPEND=">=xfce-base/xfce4-panel-4.3.20
	>=xfce-base/libxfcegui4-4.3.20
	>=xfce-base/libxfce4util-4.3.20
	>=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	# $(xfconf_use_debug) removed because the package is still using
	# libxfcegui4.  restore when ported to libxfce4ui.
	XFCONF=(
		--disable-dependency-tracking
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}
