# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeui/libgnomeui-2.8.0.ebuild,v 1.7 2004/12/11 10:20:36 kloeri Exp $

inherit gnome2

DESCRIPTION="User Interface routines for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc ~hppa ~amd64 ~ia64 ~mips ~ppc64 ~arm"
IUSE="doc jpeg"

RDEPEND=">=x11-libs/gtk+-2.4.1
	>=x11-libs/pango-1.1.2
	>=dev-libs/popt-1.5
	>=media-sound/esound-0.2.26
	>=media-libs/audiofile-0.2.3
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2.7.3
	gnome-base/gnome-keyring
	jpeg? ( media-libs/jpeg )"

# FIXME : jpeg stuff no switch

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.6 )"

PDEPEND="x11-themes/gnome-themes
	x11-themes/gnome-icon-theme"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
