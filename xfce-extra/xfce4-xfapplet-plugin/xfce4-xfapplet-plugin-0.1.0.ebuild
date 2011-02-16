# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xfapplet-plugin/xfce4-xfapplet-plugin-0.1.0.ebuild,v 1.6 2011/02/16 22:30:22 angelos Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Panel plugin to support GNOME applets"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-xfapplet-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.4:2
	>=xfce-base/xfce4-panel-4.3.20
	>=xfce-base/libxfcegui4-4.2
	>=gnome-base/orbit-2.12.5
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README"
}
