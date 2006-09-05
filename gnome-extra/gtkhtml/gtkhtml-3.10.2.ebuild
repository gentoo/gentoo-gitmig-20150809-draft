# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-3.10.2.ebuild,v 1.8 2006/09/05 04:01:17 kumba Exp $

inherit gnome2 eutils

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="3.8"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gail-1.1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprintui-2.2.1
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2.2.4
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	>=net-libs/libsoup-2.1.6
	>=x11-libs/gtk+-2.4
	>=x11-themes/gnome-icon-theme-1.2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	>=dev-util/pkgconfig-0.9"

ELTCONF="--reverse-deps"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"
