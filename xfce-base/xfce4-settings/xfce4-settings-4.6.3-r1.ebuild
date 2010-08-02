# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-settings/xfce4-settings-4.6.3-r1.ebuild,v 1.11 2010/08/02 18:42:36 armin76 Exp $

EAPI=2
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Settings daemon for Xfce4"
HOMEPAGE="http://www.xfce.org"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug +keyboard libnotify sound"

RDEPEND=">=dev-libs/glib-2.12:2
	>=dev-libs/dbus-glib-0.34
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2.10:2
	>=x11-libs/libX11-1
	>=x11-libs/libXcursor-1.1
	>=x11-libs/libXi-1.3
	>=x11-libs/libXrandr-1.1
	>=x11-libs/libwnck-2.12
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	>=xfce-base/exo-0.3.100
	libnotify? ( >=x11-libs/libnotify-0.1.3 )
	keyboard? ( >=x11-libs/libxklavier-0.3 )
	sound? ( media-libs/libcanberra )
	!<x11-base/xorg-server-1.5.3"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig
	x11-proto/inputproto
	x11-proto/xf86vidmodeproto"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable libnotify)
		$(use_enable keyboard libxklavier)
		$(use_enable sound sound-settings)
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog NEWS TODO"
	PATCHES=( "${FILESDIR}/${P}-exo.patch"
		"${FILESDIR}/${P}-Xi.patch"
		"${FILESDIR}/${PN}-4.7.1-libxklavier.patch" )
}
