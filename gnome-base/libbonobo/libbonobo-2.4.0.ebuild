# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.4.0.ebuild,v 1.11 2004/11/08 15:01:29 vapier Exp $

inherit gnome2

DESCRIPTION="GNOME CORBA framework"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 arm"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.0.1
	>=gnome-base/orbit-2.8
	>=dev-libs/libxml2-2.4.20
	!gnome-base/bonobo-activation"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	doc? ( >=dev-util/gtk-doc-0.10 )"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"
