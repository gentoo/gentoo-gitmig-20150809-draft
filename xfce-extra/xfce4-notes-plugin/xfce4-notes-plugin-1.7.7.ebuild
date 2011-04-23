# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notes-plugin/xfce4-notes-plugin-1.7.7.ebuild,v 1.10 2011/04/23 17:41:24 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Xfce4 panel sticky notes plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-notes-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.18:2
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/xfce4-panel-4.4
	>=xfce-base/xfconf-4.6
	dev-libs/libunique:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	# $(xfconf_use_debug) removed because the package is still using
	# deprecated libxfcegui4 functions. restore when the package has
	# been migrated to libxfce4ui.
	XFCONF=(
		--disable-dependency-tracking
		--disable-static
		)

	DOCS="AUTHORS ChangeLog NEWS README"
}
