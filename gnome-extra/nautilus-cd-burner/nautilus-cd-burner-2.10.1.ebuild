# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-2.10.1.ebuild,v 1.11 2005/08/08 14:54:55 corsair Exp $

inherit gnome2

DESCRIPTION="CD and DVD writer plugin for Nautilus"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="cdr dvdr hal"

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.5.4
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	hal? ( >=sys-apps/hal-0.4.2 )
	cdr? ( virtual/cdrtools )
	dvdr? ( app-cdr/dvd+rw-tools )"

DEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.5.4
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	hal? ( >=sys-apps/hal-0.4.2 )
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9.0"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} $(use_enable hal)"

USE_DESTDIR="1"
