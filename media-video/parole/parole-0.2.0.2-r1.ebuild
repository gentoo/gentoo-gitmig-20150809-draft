# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/parole/parole-0.2.0.2-r1.ebuild,v 1.7 2011/05/19 22:28:49 ssuominen Exp $

EAPI=4
inherit multilib nsplugins xfconf

DESCRIPTION="a simple media player based on the GStreamer framework for the Xfce4 desktop"
HOMEPAGE="http://goodies.xfce.org/projects/applications/parole/"
SRC_URI="mirror://xfce/src/apps/${PN}/0.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug libnotify nsplugin taglib"

RDEPEND=">=x11-libs/gtk+-2.16:2
	>=dev-libs/glib-2.16:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=dev-libs/dbus-glib-0.88
	>=media-libs/gstreamer-0.10.11:0.10
	>=media-libs/gst-plugins-base-0.10.11:0.10
	media-plugins/gst-plugins-meta:0.10
	libnotify? ( >=x11-libs/libnotify-0.4.5 )
	taglib? ( >=media-libs/taglib-1.4 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	x11-proto/xproto"

pkg_setup() {
	export BROWSER_PLUGIN_DIR="/usr/$(get_libdir)/${PLUGINS_DIR}" #333517

	PATCHES=(
		"${FILESDIR}"/${P}-64bit.patch
		"${FILESDIR}"/${P}-libnotify-0.7.patch
		)

	XFCONF=(
		$(use_enable libnotify)
		$(use_enable taglib)
		$(use_enable nsplugin browser-plugin)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog README THANKS TODO )
}
