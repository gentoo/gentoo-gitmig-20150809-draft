# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-verve-plugin/xfce4-verve-plugin-1.0.0.ebuild,v 1.2 2011/03/11 19:36:13 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A comfortable command line plugin for the Xfce panel"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-verve-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="dbus"

RDEPEND=">=xfce-base/exo-0.3.1.3
	>=xfce-base/xfce4-panel-4.4
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=dev-libs/libpcre-5
	dbus? ( >=dev-libs/dbus-glib-0.88 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	# $(xfconf_use_debug) removed because the package is still using
	# libxfcegui4.   restore when ported to libxfce4ui.
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable dbus)
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}
