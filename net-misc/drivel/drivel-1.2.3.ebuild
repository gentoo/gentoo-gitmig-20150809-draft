# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-1.2.3.ebuild,v 1.4 2005/03/26 03:39:19 obz Exp $

inherit gnome2

DESCRIPTION="Drivel is a LiveJournal client for the GNOME desktop."
HOMEPAGE="http://www.dropline.net/drivel/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="spell"
SLOT="0"
KEYWORDS="~x86 ~ppc"

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
	>=net-misc/curl-7.12.0
	spell? ( >=app-text/gtkspell-2.0 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	>=app-text/scrollkeeper-0.3.5"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

G2CONF="${G2CONF} `use_with spell gtkspell` --without-rhythmbox"

USE_DESTDIR="1"
