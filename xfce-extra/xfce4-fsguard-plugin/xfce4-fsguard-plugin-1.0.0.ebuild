# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-fsguard-plugin/xfce4-fsguard-plugin-1.0.0.ebuild,v 1.3 2011/03/13 16:29:14 hwoarang Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Filesystem guard panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-fsguard-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/xfce4-panel-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/libxfce4util-4.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	# $(xfconf_use_debug) removed because the package is still using
	# deprecated libxfcegui4 functions. restore when the package has
	# been migrated to libxfce4ui.
	XFCONF=(
		--disable-dependency-tracking
		)
	DOCS="AUTHORS ChangeLog NEWS README"
}
