# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-1.2.1.ebuild,v 1.4 2004/12/06 06:25:09 joem Exp $

inherit gnome2

DESCRIPTION="Drivel is a LiveJournal client for the GNOME desktop."
HOMEPAGE="http://sourceforge.net/project/drivel/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc"

# note: there's also an optional rhythmbox dependency

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2
	>=gnome-base/gnome-vfs-2.6
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/libbonobo-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2
	>=x11-libs/gtksourceview-1
	>=net-misc/curl-7.12.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

G2CONF="${G2CONF} --without-rhythmbox"

src_unpack() {
	unpack ${A}

#	sed -e 's/-DGTK_DISABLE_DEPRECATED//g' -i ${S}/src/Makefile.in
#	sed -e 's/-DGNOME_DISABLE_DEPRECATED//g' -i ${S}/src/Makefile.in
}
