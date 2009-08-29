# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-volstatus-icon/xfce4-volstatus-icon-0.1.0-r1.ebuild,v 1.6 2009/08/29 17:23:37 armin76 Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Systray status icon for safe unmount/eject of volumes"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/exo-0.3.2[hal]
	>=sys-apps/hal-0.5.9
	>=dev-libs/dbus-glib-0.70"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}/${P}-dialog_segfault.patch" )
	DOCS="AUTHORS ChangeLog README TODO"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}
