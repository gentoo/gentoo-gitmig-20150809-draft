# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.16.ebuild,v 1.1 2003/06/24 00:57:15 foser Exp $

inherit gnome2

DESCRIPTION="A little girl in the woods looking for printers"
HOMEPAGE="http://foo.bar.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.1.4"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20"
