# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-0.5.3.ebuild,v 1.13 2004/07/14 15:59:44 agriffis Exp $

inherit gnome2

DESCRIPTION="CD writer plugin for Nautilus"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 hppa ia64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/eel-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	app-cdr/cdrtools"

DEPEND=">=dev-util/intltool-0.22
	>=dev-util/pkgconfig-0.9.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"
