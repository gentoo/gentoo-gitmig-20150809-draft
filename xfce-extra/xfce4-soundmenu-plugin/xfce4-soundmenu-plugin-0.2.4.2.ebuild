# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-soundmenu-plugin/xfce4-soundmenu-plugin-0.2.4.2.ebuild,v 1.1 2011/12/23 06:57:49 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A panel plug-in to control MPRIS2 compatible players"
HOMEPAGE="http://code.google.com/p/dissonance/"
SRC_URI="http://dissonance.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +glyr lastfm"

RDEPEND=">=dev-libs/dbus-glib-0.92
	>=dev-libs/keybinder-0.2
	x11-libs/libX11
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8
	glyr? ( media-libs/glyr )
	lastfm? ( media-libs/libclastfm )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		$(use_enable lastfm libclastfm)
		$(use_enable glyr libglyr)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )
}
