# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.8.1.ebuild,v 1.10 2006/09/05 02:08:44 kumba Exp $

inherit gnome2

DESCRIPTION="GNOME CORBA framework"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.3.2
	>=gnome-base/orbit-2.12.0
	>=dev-libs/libxml2-2.4.20
	dev-libs/popt
	!gnome-base/bonobo-activation"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

USE_DESTDIR="1"
