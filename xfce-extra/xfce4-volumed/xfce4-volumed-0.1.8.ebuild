# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-volumed/xfce4-volumed-0.1.8.ebuild,v 1.6 2011/01/29 23:59:53 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Daemon to control volume up/down and mute keys"
HOMEPAGE="https://launchpad.net/xfce4-volumed"
SRC_URI="mirror://xfce/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug libnotify"

COMMON_DEPEND="xfce-base/xfconf
	>=x11-libs/xcb-util-0.3.5
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	libnotify? ( <x11-libs/libnotify-0.7 )"
RDEPEND="${COMMON_DEPEND}
	media-plugins/gst-plugins-meta:0.10"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable debug)
		$(use_with libnotify)
		)
	DOCS="AUTHORS ChangeLog README THANKS"
}
