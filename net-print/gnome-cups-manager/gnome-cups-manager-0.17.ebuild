# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.17.ebuild,v 1.3 2003/08/13 00:47:06 lu_zero Exp $

inherit gnome2

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.1.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20"
