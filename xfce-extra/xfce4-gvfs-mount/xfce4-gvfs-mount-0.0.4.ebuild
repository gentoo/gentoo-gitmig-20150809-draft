# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-gvfs-mount/xfce4-gvfs-mount-0.0.4.ebuild,v 1.2 2010/12/18 19:40:14 ssuominen Exp $

EAPI=3
inherit xfconf

MY_REV=6d2684b

DESCRIPTION="A panel plug-in to mount remote filesystems for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-gvfs-mount"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.0/${P}-${MY_REV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.12:2
	>=gnome-base/libglade-2.6
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/xfce4-panel-4.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

S=${WORKDIR}/${P}-${MY_REV}

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS NEWS README"
}
