# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonoboui/libbonoboui-2.4.3.ebuild,v 1.3 2004/02/10 06:30:07 darkspecter Exp $

inherit gnome2

DESCRIPTION="User Interface part of libbonobo"
HOMEPAGE="http://www.gnome.org/"

IUSE="doc"
SLOT="0"
KEYWORDS="x86 ppc ~alpha ~sparc ~hppa ~amd64"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libbonobo-2.3.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.4.20"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
