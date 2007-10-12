# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-2.0.3.ebuild,v 1.6 2007/10/12 09:25:20 remi Exp $

inherit gnome2

DESCRIPTION="Drivel is a desktop blogger with support for LiveJournal, Blogger,
MoveableType, Wordpress and more."
HOMEPAGE="http://www.dropline.net/drivel/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="dbus spell"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2
	>=gnome-base/gnome-vfs-2.6
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/libbonobo-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2
	=x11-libs/gtksourceview-1*
	>=net-misc/curl-7.12.0
	spell? ( >=app-text/gtkspell-2.0 )
	dbus? ( sys-apps/dbus )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.5"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} \
	`use_with spell gtkspell` \
	`use_with dbus` \
	--disable-mime-update \
	--disable-desktop-update
	--localstatedir=${D}/var"

USE_DESTDIR="1"
