# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.6.1.ebuild,v 1.16 2010/01/11 04:17:34 vapier Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Session manager for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/xfce4-session/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug gnome gnome-keyring profile"

RDEPEND="gnome-base/libglade
	>=dev-libs/dbus-glib-0.73
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/libwnck-2.12
	x11-apps/iceauth
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	>=xfce-base/xfce-utils-4.6
	gnome? ( gnome-base/gconf )
	gnome-keyring? ( gnome-base/gnome-keyring )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		--disable-static
		$(use_enable gnome)
		$(use_enable gnome-keyring libgnome-keyring)
		$(use_enable debug)
		$(use_enable profile profiling)
		$(use_enable profile gcov)"
	DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"
}

pkg_postinst() {
	xfconf_pkg_postinst
	elog "If you would like to see fortunes with xfce4-tips, then install
	games-misc/fortune-mod"
}
