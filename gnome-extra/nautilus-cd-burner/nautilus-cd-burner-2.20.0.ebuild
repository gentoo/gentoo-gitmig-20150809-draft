# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-2.20.0.ebuild,v 1.11 2009/05/14 21:29:09 eva Exp $

inherit gnome2

DESCRIPTION="CD and DVD writer plugin for Nautilus"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="arm sh"
IUSE="cdr dvdr"

RDEPEND=">=gnome-base/gnome-vfs-2.1.3.1
	>=dev-libs/glib-2.10
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/eel-2.14
	>=gnome-base/nautilus-2.16
	>=gnome-base/gconf-2
	>=gnome-base/gnome-mount-0.4
	>=sys-apps/hal-0.5.7
	>=dev-libs/dbus-glib-0.71
	cdr? ( virtual/cdrtools )
	dvdr? ( >=app-cdr/dvd+rw-tools-6.1 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --enable-gnome-mount"
}
