# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-power-manager/xfce4-power-manager-0.8.5.ebuild,v 1.2 2010/06/29 07:19:58 angelos Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Power manager for Xfce4"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-power-manager"
SRC_URI="mirror://xfce/src/apps/${PN}/0.8/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc +plugins"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.70
	>=dev-libs/glib-2.16:2
	>=gnome-base/libglade-2
	>=sys-apps/hal-0.5.6
	>=x11-libs/gtk+-2.12:2
	>=x11-libs/libnotify-0.4.1
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	plugins? ( >=xfce-base/xfce4-panel-4.6 )
	x11-libs/libXext"
RDEPEND="${COMMON_DEPEND}
	gnome-base/librsvg"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	x11-proto/xproto
	doc? ( dev-libs/libxslt )"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		--enable-dpms
		$(use_enable plugins panel-plugins)
		$(use_enable doc xsltproc)
		$(xfconf_use_debug)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}
