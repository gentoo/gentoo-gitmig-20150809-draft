# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-2.11.6.ebuild,v 1.1 2005/08/19 20:24:10 joem Exp $

inherit eutils gnome2

DESCRIPTION="CD and DVD writer plugin for Nautilus"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="cdr dvdr hal static"

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.5.4
	>=gnome-base/gnome-vfs-2.1.3.1
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.5.5
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	hal? ( >=sys-apps/hal-0.4.2 )
	cdr? ( virtual/cdrtools )
	dvdr? ( app-cdr/dvd+rw-tools )"

DEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.5.4
	>=gnome-base/gnome-vfs-2.1.3.1
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.5.5
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	hal? ( >=sys-apps/hal-0.4.2 )
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.17"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"

G2CONF="${G2CONF} $(use_enable hal) $(use_enable static)"

USE_DESTDIR="1"

