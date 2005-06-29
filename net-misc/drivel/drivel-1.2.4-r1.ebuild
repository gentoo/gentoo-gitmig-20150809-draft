# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-1.2.4-r1.ebuild,v 1.1 2005/06/29 00:05:54 allanonjl Exp $

inherit gnome2

DESCRIPTION="Drivel is a LiveJournal client for the GNOME desktop."
HOMEPAGE="http://www.dropline.net/drivel/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="rhythmbox spell"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"

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
	spell? ( >=app-text/gtkspell-2.0 )
	rhythmbox? ( media-sound/rhythmbox )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	>=app-text/scrollkeeper-0.3.5"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

G2CONF="${G2CONF} \
	`use_with spell gtkspell` \
	`use_with rhythmbox` \
	--disable-mime-update \
	--disable-desktop-update"

USE_DESTDIR="1"

src_install() {
	# fix for access violation due to eclass change
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
}
