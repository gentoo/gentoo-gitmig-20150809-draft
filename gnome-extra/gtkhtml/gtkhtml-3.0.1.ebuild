# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-3.0.1.ebuild,v 1.2 2003/03/19 14:29:30 liquidx Exp $

inherit gnome.org gnome2

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnomeprint-2.2
    >=gnome-base/libgnomeprintui-2.2.1
    >=gnome-base/libbonoboui-2.0
    >=gnome-base/bonobo-activation-2.0
    >=gnome-base/libbonobo-2.0
    >=gnome-extra/gal-1.99.2
    >=gnome-base/ORBit2-2.5.6
    >=net-libs/libsoup-1.99.12
	>=dev-libs/libxml2-2.5
	>=gnome-base/gnome-vfs-2.1
    >=gnome-base/gail-1.1"
 
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

SCROLLKEEPER_UPDATE="0"
