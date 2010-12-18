# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-stopwatch-plugin/xfce4-stopwatch-plugin-0.2.0.ebuild,v 1.5 2010/12/18 21:00:23 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A panel plug-in to track elapsed time for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-stopwatch-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.2/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfce4-panel-4.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	if has_version ">=xfce-base/xfce4-panel-4.7"; then
		die "Sorry, but this plug-in is only for Xfce 4.6. See bug 344653."
	fi

	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS NEWS"
}
