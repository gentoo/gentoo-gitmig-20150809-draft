# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.14.0.ebuild,v 1.14 2006/10/19 15:30:12 kloeri Exp $

inherit gnome2

DESCRIPTION="GNOME CORBA framework"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="debug doc"

RDEPEND=">=dev-libs/glib-2.8
	>=gnome-base/orbit-2.14.0
	>=dev-libs/libxml2-2.4.20
	>=dev-libs/popt-1.5
	!gnome-base/bonobo-activation"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="$(use_enable debug bonobo-activation-debug)"
}
