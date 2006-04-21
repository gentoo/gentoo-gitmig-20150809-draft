# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-2.12.3.ebuild,v 1.9 2006/04/21 20:51:32 tcort Exp $

inherit gnome2

DESCRIPTION="CD and DVD writer plugin for Nautilus"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="cdr dvdr hal static"

RDEPEND=">=gnome-base/gnome-vfs-2.1.3.1
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.5.4
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.5.5
	>=gnome-base/gconf-2
	hal? ( >=sys-apps/hal-0.5 )

	cdr? ( virtual/cdrtools )
	dvdr? ( app-cdr/dvd+rw-tools )"

DEPEND=">=gnome-base/gnome-vfs-2.1.3.1
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.5.4
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.5.5
	>=gnome-base/gconf-2
	hal? ( >=sys-apps/hal-0.5 )

	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable hal) $(use_enable static)"
}
