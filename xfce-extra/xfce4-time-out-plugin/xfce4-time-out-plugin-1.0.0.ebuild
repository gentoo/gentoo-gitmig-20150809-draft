# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-time-out-plugin/xfce4-time-out-plugin-1.0.0.ebuild,v 1.5 2011/03/22 10:50:07 tomka Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A panel plug-in to take periodical breaks from the computer"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-time-out-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8:2
	>=xfce-base/xfce4-panel-4.3.99.2
	>=xfce-base/libxfce4util-4.3.99.2
	>=xfce-base/libxfcegui4-4.3.99.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	# $(xfconf_use_debug) removed because this package is still using
	# libxfcegui4.  restore when ported to libxfce4ui.
	XFCONF=(
		--disable-dependency-tracking
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}
